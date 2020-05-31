module ValidateHandler
  # module defines methods based on `validate` function calls from User class
  # for example `validate :first_name, presence: true` on initialization
  # creates `validation_first_name_presence` method which call `presence(:first_name, true)` method.

  def validate(attr, options)
    options.keys.each do |key|
      validation_name(attr, key)
      define_method(validation_name(attr, key)) do
        send(key, attr, options[key])
      end
    end
  end

  private

  def validation_name(attr, key)
    "validation_#{attr}_#{key}"
  end
end
