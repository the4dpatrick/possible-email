require 'possible_email/profile/membership'
require 'possible_email/profile/occupation'
require 'possible_email/profile/image'
require 'possible_email/profile/phone'

module PossibleEmail
  class NoDataError < ArgumentError; end

  class Profile
    attr_reader :data, :email, :name, :first_name, :last_name, :friendly_name,
                :location, :headline, :success, :occupations, :memberships,
                :images, :phones

    def initialize(data)
      @data = data

      fail NoDataError, 'Data given was empty' if @data.empty?

      retrieve_attribute
      retrieve_attribute_collection
    end

    def attributes
      instance_variables.select { |i| i != :@data }.map { |i| i.to_s[1..-1] }
    end

    def to_s
      "#{@name} - #{email}"
    end

    private

    def retrieve_attribute
      %w(email name first_name last_name friendly_name location headline).each do |attr|
        instance_variable_set("@#{attr}", @data['contact'][attr])
      end
      @success = @data['success']
    end

    def retrieve_attribute_collection
      %w(occupations memberships images phones).each do |collection|
        build_collection_instance_variable(collection)
      end
    end

    def build_collection_instance_variable(collection)
      collection_array = @data['contact'][collection].reduce([]) do |col, c|
        col << find_klass_name(collection).new(c)
      end

      instance_variable_set("@#{collection}", collection_array)
    end

    def find_klass_name(collection)
      PossibleEmail.const_get collection[0..-2].capitalize # 'images' => 'Image'
    end
  end
end
