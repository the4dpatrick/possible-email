require 'possible_email/error'
require 'possible_email/version'
require 'possible_email/permutator'
require 'possible_email/rapportive_requester'

require 'httpi'
require 'json'

HTTPI.log = false

EMAIL_REGEX = /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i
DOMAIN_REGEX = /^[^@]([\w\-]+\.)+([\w]{2,})$/
NAME_REGEX = /^\b[a-zA-Z]+\b$/

module PossibleEmail
  class InvalidNameFormat < ArgumentError; end
  class InvalidEmailFormat < ArgumentError; end

  module_function

  def search(first_name, last_name, *domain)
    assign_instance_variables first_name, last_name, domain

    fail InvalidNameFormat, "Name arguments were not formatted correctly #{[@first_name, @last_name, *@domain].inspect}" unless valid_names?

    permutations = Permutator.call(@first_name, @last_name, @domain)
    RapportiveRequester.request(permutations)
  end

  def find_profile(*emails)
    @emails = emails.flatten

    fail InvalidEmailFormat, "Email arguments were not formatted correctly #{@emails.inspect}" if invalid_emails?

    RapportiveRequester.request(@emails)
  end

  private_class_method

  def assign_instance_variables(first_name, last_name, domain)
    @first_name = first_name
    @last_name = last_name
    @domain = domain.flatten
  end

  def invalid_emails?
    @emails.any? { |email| email !~ EMAIL_REGEX }
  end

  def valid_names?
    valid_domain = @domain.all? { |d| d =~ DOMAIN_REGEX }
    valid_names = [@first_name, @last_name].all? { |n| n =~ NAME_REGEX }

    valid_domain && valid_names
  end
end
