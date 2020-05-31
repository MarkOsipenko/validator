#!/usr/bin/env ruby

require './user.rb'

class ValidatorTest
  def valid?(user = User.new, expect)
    user.validate

    result(user.valid?, expect)
  end

  def valid_with_exeption (user = User.new, expect)
    user.validate!
  rescue => e
    result(e.message, expect)
  end

  def result(let, expect)
    if let == expect
      "\e[32m#{'+'}\e[0m"
    else
      "\e[31m#{'F'}\e[0m"
    end
  end
end

# presence
valid_user1   = User.new(first_name: "Jon", number: 50)
invalid_user1 = User.new(first_name: "", number: 50)

puts [
  ValidatorTest.new.valid?(valid_user1, true),
  ValidatorTest.new.valid?(invalid_user1, false),
  ValidatorTest.new.valid_with_exeption(invalid_user1, "{\"first_name\"=>\"Field should contain at least one character\"}")
].join(" ")
