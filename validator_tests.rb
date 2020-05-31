#!/usr/bin/env ruby

require './user.rb'

user1 = User.new(first_name: "Jon", last_name: 'Travolta', age: 50)

p "#{user1.first_name} #{user1.last_name}, #{user1.age} years, valid: #{user1.valid?}"
