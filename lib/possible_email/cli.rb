require 'thor'

module PossibleEmail
  class CLI < Thor
    # possible_email search

    desc 'search', 'Search for valid emails using first name, last name, and domain name'
    long_desc <<-LONGDESC
Takes in a first name, last name, and domain name.

Domain name can be a single domain like 'gmail.com', or multiple domain names like 'gmail.com', 'yahoo.com'

Prints out all of the found email profiles for valid email addresses with associated information
LONGDESC

    def search(first_name, last_name, *domain)
      profiles = PossibleEmail.search(first_name, last_name, domain)
      puts profiles
    end

    # possible_email find_profile

    desc 'find_profile', 'return a profile for one or more email addresses'
    long_desc <<-LONGDESC
Prints out all of the found email profiles for valid email addresses with associated information
LONGDESC

    def find_profile(*emails)
      profiles = PossibleEmail.find_profile(emails)
      puts profiles
    end
  end
end
