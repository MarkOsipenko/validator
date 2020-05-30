require './validator.rb'

class User
  include Validator

  def initialize(attrs)
    initialize_attributes(attrs)
  end

  def initialize_attributes(attrs)
    permitted_attributes.each do |key|
      instance_variable_set("@#{key}", attrs[key])
      define_singleton_method(key) { instance_variable_get("@#{key}")}
    end
  end

  def permitted_attributes
    [:first_name, :last_name, :age]
  end
end