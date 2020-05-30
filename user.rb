require './validator.rb'

class User
  include Validator

  def initialize(attrs)
    @first_name = attrs[:first_name]
    @last_name = attrs[:last_name]
    @age = attrs[:age]
  end
end