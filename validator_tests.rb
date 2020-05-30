#!/usr/bin/env ruby

require './user.rb'

user1 = User.new(name: "Jon", last_name: 'Travolta', age: 50)

p user1.valid?