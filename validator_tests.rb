#!/usr/bin/env ruby

require './user.rb'

class ValidatorTest
  def test(user = User.new, result)
    if user.valid? == result
      "\e[32m#{'+'}\e[0m"
    else
      "\e[31m#{'F'}\e[0m"
    end
  end
end

valid_user1 =   User.new(first_name: "Jon", last_name: 'Travolta', age: 50)
invalid_user1 = User.new(first_name: "", last_name: 'Travolta', age: 50)

puts [
  ValidatorTest.new.test(valid_user1, true),
  ValidatorTest.new.test(invalid_user1, true)
].join(" ")
