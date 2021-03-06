require './validator.rb'

class User
  include Validator

  validate :first_name, presence: true
  validate :number, format: /[A-Z]{3}/
  validate :class_type, kind: User

  def initialize(attrs)
    initialize_permitted_attributes(attrs)
  end

  private

  def initialize_permitted_attributes(attrs)
    permitted_attributes.each do |key|
      instance_variable_set("@#{key}", attrs[key])

      define_singleton_method(key) { instance_variable_get("@#{key}")}
    end
  end

  def permitted_attributes
    [:first_name, :number]
  end
end
