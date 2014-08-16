PossibleEmail
=========
A Ruby Gem to find someone's possible email address using their first name, last name, and domain.

[![Gem Version](https://badge.fury.io/rb/possible_email.svg)](http://badge.fury.io/rb/possible_email)
[![Build Status](https://travis-ci.org/the4dpatrick/possible-email.svg?branch=master)](https://travis-ci.org/the4dpatrick/possible-email)
[![Coverage Status](https://coveralls.io/repos/the4dpatrick/possible-email/badge.png?branch=master)](https://coveralls.io/r/the4dpatrick/possible-email?branch=master)
[![Code Climate](https://codeclimate.com/github/the4dpatrick/possible-email/badges/gpa.svg)](https://codeclimate.com/github/the4dpatrick/possible-email)

More information in my [blog post](http://patrickperey.com/possible-email "blog post") at [PatrickPerey.com](http://patrickperey.com "Patrick Perey Blog")

Installation
------------
Install the gem:

```
$ gem install possible_email
```

Basic Usage
-----

### Command Line Interface


Enter target's first name, last name, and possible domain name into the terminal using `search`

```
$ possible_email search first_name last_name domain
```

Not sure about the domain name? Just add multiple domains at the end

```
$ possible_email search first_name last_name gmail.com, yahoo.com, live.com
```


Just want to Confirm a single email address? Use `find_profile`

```
$ possible_email find_profile test@example.com
```
Multiple email address? Same `find_profile`

```
$ possible_email find_profile test@example.com test1@example.com
```
### Ruby

```ruby
require 'possible_email'

profiles = PossibleEmail.search('Kevin', 'Rose', 'gmail.com')
profiles #=> "#<PossibleEmail::Response>"
first_profile = profiles.first

first_profile.name #=> 'Kevin Rose'
first_profile.email #=> 'kevinrose@gmail.com'
first_profile.location #=> 'San Francisco Bay Area'
```
Documentation
-------------
### PossibleEmail

Available methods:

**search(first_name, last_name, *domain)**

Accepts three arguments `first_name`, `last_name`, and `domain`. PossibleEmail will use these three arguments to generate possible email addresses based on common email address patterns. PossibleEmail would then attempt to verify and return an email profile for each email address.

```ruby
# Single domain name
PossibleEmail.search('bob', 'jones', 'gmail.com')

# Multiple domain names as Strings
PossibleEmail.search('bob', 'jones', 'gmail.com', 'yahoo.com')

# Multiple domain names as an Array
domains = ['gmail.com', 'yahoo.com', 'live.com']
PossibleEmail.search('bob', 'jones', domains)
```

**find_profile(*emails)**

Accepts a list of email address string arguments or an array. Instead of generating email addresses based on name arguments, PossibleEmail would attempt to verify and return an email profile for each email addresses passed into the method.

```ruby
# Comma-splitted email arguments
PossibleEmail.find_profile('test@example.com', 'test1@example.com')

# Array of emails
PossibleEmail.find_profile(['test@example.com', 'test1@example.com'])
```

Both methods return a `PossibleEmail::Response` object. `PossibleEmail::Response` includes the `Enumerable` module, so all the methods you need to iterate through the profiles are available. The only exception when neither the `search` or `find_profile` is when there is only one profile within the response. In this case, the method returns the single Profile.

### Profile

Class for the associated data connnected with a specific email address.

`Profile` attribute list:

* `email` - Returns the profile's email address
* `name` - Full name
* `first_name` - First name
* `last_name` - Last name
* `friendly_name` - First name or named used to address this person
* `location` - Location
* `headline` - Short blurb about person
* `success` - Type of response returned back from Rapportive API
* `occupations` - Array of Occupation objects
* `memberships` - Array of social network Membership objects
* `images` - Array of Image objects

### Occupation

Class for person's jobs.

`Occupation` attribute list:

* `job_title` - Job title
* `company` - Company

### Membership

Class for Social Network Accounts

`Membership` attribute list:

* `profile_url` - URL to person's website membership
* `profile_id` - Website profile ID
* `username` - Username
* `site_name` - Name of the website membership

### Image

Class for images associated with email profile.

`Image` attribute list:

* `url` - Image url
* `service` - Where the image is located
* `url_proxied` - Rapportive image proxied URL

Notes
-----
* With great power, comes great responsibly
* Wrapper around the undocumented Rapportive API.
* Valid results may be hidden due to API's limitations
* Send Bitcoin `18fZ6muNmBrtENMZhnAjUw8eEsytmY8mZJ`


Contributing
------------

1. Fork it ( http://github.com/the4dpatrick/possible-email )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
