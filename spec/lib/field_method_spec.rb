require_relative '../../lib/field_method'

# TODO: change FieldMethod.new to take a hash
# TODO: backtest
# TODO: Overrides won't be used when calling field methods.
#   Is this really a problem? If you want an individual field, you can 
#   #to_hash[:field], and if you want to call a specific field you do
#   FieldMethod#send_to(product)

RSpec.describe FieldMethod do
end
