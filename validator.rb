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

  # ------- validation methods --------------------------------------

  def presence(attr, bool)
    if bool && send(attr) == ('' || ' ')
      send "invalid=", true
      errors_add(attr, :presence)
    end
  end

  def format(attr, regex)
    if regex.match?(send(attr))
      send "invalid=", false
    else
      send "invalid=", true
      errors_add(attr, :format)
    end
  end

  # ---------------------------------------------------------------

  def invalid=(bool)
    if bool && invalid?.nil?
      instance_variable_set(:@invalid, true)
    elsif !invalid?
      instance_variable_set(:@invalid, false)
    end
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

  def validate_attributes
    list_of_validations.each { |f| send(f) }
  end

  def validate_attributes!
    validate_attributes

    raise StandardError.new errors.first if invalid?
  end

  def errors_add(attr, option)
    errors << { "#{attr}" => errors_list[option] }
  end

  def list_of_validations
    (methods - Object.methods).grep(/validation_/)
  end

  def errors_list
    {
      presence: 'Field should contain at least one character',
      format: 'Format should be [A-Z]{3}'
    }
  end
end
