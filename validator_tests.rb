#!/usr/bin/env ruby

require './user.rb'

class ValidatorTest
  def valid?(user, expect)
    user.validate

    result(user.valid?, expect)
  end

  def valid_with_exeption(user, expect)
    user.validate!

    result(user.valid?, expect)
  rescue => e
    result(e.message, expect)
  end

  private

  def result(let, expect)
    return "\e[32m#{'+'}\e[0m" if let == expect

    "\e[31m#{'F'}\e[0m"
  end
end

# presence
valid_user1   = User.new(first_name: "Jon", number: "AAA")
invalid_user1 = User.new(first_name: "", number: "AAA")

# format
valid_user2   = User.new(first_name: "Jon", number: "AAA")
invalid_user2 = User.new(first_name: "Jon", number: "A")

# kind
valid_user3   = User.new(first_name: "Jon", number: "AAA")

class BadUser < User; end
invalid_user3 = BadUser.new(first_name: "Jon", number: "AAA")

puts [
  # presence
  ValidatorTest.new.valid?(valid_user1, true),
  ValidatorTest.new.valid?(invalid_user1, false),
  ValidatorTest.new.valid_with_exeption(valid_user1, true),
  ValidatorTest.new.valid_with_exeption(invalid_user1, "{\"first_name\"=>\"Field should contain at least one character\"}"),

  # format
  ValidatorTest.new.valid?(valid_user2, true),
  ValidatorTest.new.valid?(invalid_user2, false),
  ValidatorTest.new.valid_with_exeption(valid_user2, true),
  ValidatorTest.new.valid_with_exeption(invalid_user2, "{\"number\"=>\"Format should be [A-Z]{3}\"}"),

  # kind
  ValidatorTest.new.valid?(valid_user3, true),
  ValidatorTest.new.valid?(invalid_user3, false),
  ValidatorTest.new.valid_with_exeption(valid_user3, true),
  ValidatorTest.new.valid_with_exeption(invalid_user3, "{\"class_type\"=>\"Kind should be a User\"}"),
].join(" ")
