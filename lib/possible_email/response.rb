module PossibleEmail
  class Response
    include Enumerable

    def initialize(profiles)
      # remove nils created by ResponseGetter
      @profiles = profiles.compact
    end

    def each(&block)
      @profiles.each(&block)
    end

    def [](*args)
      @profiles[*args]
    end

    def method_missing(method, *)
      respond_to?(method) ? @profiles.send(method) : super
    end

    def respond_to?(method, *)
      @profiles.respond_to?(method)
    end
  end
end
