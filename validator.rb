require './validate_handler'

module Validator
  def self.included(base)
    base.extend(ValidateHandler)
  end

  def valid?
    true
  end
end