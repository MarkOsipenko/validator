#!/usr/bin/env ruby

require './user.rb'

class ValidatorTest
  def valid?(user = User.new, result)
    user.validate
    if user.valid? == result
      "\e[32m#{'+'}\e[0m"
    else
      "\e[31m#{'F'}\e[0m"
    end
  end
end

# presence
valid_user1   = User.new(first_name: "Jon", last_name: 'Travolta', number: 50)
invalid_user1 = User.new(first_name: "", last_name: 'Travolta', number: 50)

puts [
  ValidatorTest.new.valid?(valid_user1, true),
  ValidatorTest.new.valid?(invalid_user1, false)
].join(" ")
