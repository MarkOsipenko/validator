require './validate_handler'

module Validator
  def self.included(base)
    base.extend(ValidateHandler)
  end

  def validate
    validate_attributes

    self
  end

  def validate!
    validate_attributes!

    self
  end

  # -------validation methods--------------------------------------
  #  name_of_validation(field, condition)

  def presence(attr, bool)
    if bool && send(attr) == ('' || ' ')
      @invalid = true
      errors_add(attr, :presence)
    end
  end

  # ---------------------------------------------------------------

  def validate_attributes
    list_of_validations.each { |f| send(f) }
  end

  def validate_attributes!
    validate_attributes

    raise StandardError.new errors if invalid?
  end

  def invalid?
    @invalid
  end

  def valid?
    !invalid?
  end

  def errors
    @errors ||= []
  end

  private

  def errors_add(attr, option)
    errors << { "#{attr}" => errors_list[option] }
  end

  def list_of_validations
    (methods - Object.methods).grep(/validation_/)
  end

  def errors_list
    {
      presence: "Field should contain at least one character"
    }
  end
end
