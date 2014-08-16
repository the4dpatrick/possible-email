module PossibleEmail
  class Occupation
    attr_reader :job_title, :company

    def initialize(data)
      @job_title = data['job_title']
      @company = data['company']
    end
  end
end
