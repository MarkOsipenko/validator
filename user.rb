require './validator.rb'

class User
  include Validator

  validate :first_name, presence: true

  def initialize(attrs)
    initialize_permitted_attributes(attrs)
  end

  def validate
    validate_attributes
  end

  private

  def initialize_permitted_attributes(attrs)
    permitted_attributes.each do |key|
      instance_variable_set("@#{key}", attrs[key])

      define_singleton_method(key) { instance_variable_get("@#{key}")}
    end
  end

  def validate_attributes
    list_of_validations.each { |f| send(f) }
  end

  def permitted_attributes
    [:first_name, :last_name, :age]
  end
end
