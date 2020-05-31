require './validate_handler'

module Validator
  def self.included(base)
    base.extend(ValidateHandler)
  end

  # -------validation methods--------------------------------------
  #  name_of_validation(field, condition)

  def presence(attr, bool)
    if bool && send(attr) == ('' || ' ' || nil)
      @invalid = true
      errors_add(attr, :presence)
    end
  end

  # ---------------------------------------------------------------

  def validate_attributes
    list_of_validations.each { |f| send(f) }
  end

  def invalid
    @invalid
  end

  def invalid?
    @invalid
  end

  def valid
    !invalid
  end

  def valid?
    valid
  end

  def errors_add(attr, option)
    errors << { "#{attr}" => errors_list[option] }
  end

  def errors
    @errors ||= []
  end

  private

  def list_of_validations
    (methods - Object.methods).grep(/validation_/)
  end

  def errors_list
    {
      presence: "Field should contain at least one character"
    }
  end
end
