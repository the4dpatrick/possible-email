require 'possible_email/patterns'

module PossibleEmail
  class Permutator
    def self.call(first_name, last_name, *domain)
      new(first_name, last_name, domain).call
    end

    def initialize(first_name, last_name, domain)
      @first_name = first_name
      @last_name = last_name
      @domain = domain.flatten # HACK
      @first_initial = first_name.chars.first
      @last_initial = last_name.chars.first
    end

    def call
      permutations = create_all_permutations
      permutations
    end

    private

    def create_all_permutations
      @domain.reduce([]) do |permutations, domain|
        substitute_pattern_placeholders_with_correct_values(domain)

        separate_each_permutation(permutations)
      end
    end

    def substitute_pattern_placeholders_with_correct_values(domain)
      # reset after each domain iteration
      @permutation_patterns = PATTERNS.dup

      substitute_every_pattern_placeholder_except_domain

      @permutation_patterns.gsub!('{domain}', domain)
    end

    def substitute_every_pattern_placeholder_except_domain
      all_instance_variables_except_domain.each do |var|
        @permutation_patterns.gsub!(placeholder(var), value_of(var))
      end
    end

    def all_instance_variables_except_domain
      instance_variables.dup - [:@domain]
    end

    def placeholder(var)
      "{#{var.to_s[1..-1]}}"
    end

    def value_of(var)
      instance_variable_get("@#{var[1..-1]}".to_sym)
    end

    def separate_each_permutation(permutations)
      permutations << @permutation_patterns.split("\n")
      permutations.flatten
    end
  end
end
