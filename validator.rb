require './validate_handler'

module Validator
  def self.included(base)
    base.extend(ValidateHandler)
  end

  # -------validation methods--------------------------------------
  # template name_of_validation(field, condition)

  def presence(attr, bool)
    if bool
      invalid = true if attr == ('' || ' ' || nil)
    end
  end

  # ---------------------------------------------------------------

  def invalid=(bool)
    @invalid
  end

  def invalid
    @invalid
  end

  def invalid?
    @invalid
  end

  def valid?
    !invalid
  end

  private

  def list_of_validations
    (methods - Object.methods).grep("/validation")
  end
end
