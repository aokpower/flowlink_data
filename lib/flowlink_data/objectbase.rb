require_relative '../field_method'

module Flowlink
  class ObjectBase
    # Base class for any Flowlink objects. Child classes should implement
    # self.fields internally.

    def initialize(*overrides)
      overrides  = FieldMethod.multi_new(overrides)
      defaults   = FieldMethod.multi_new(fields)
      @f_methods = FieldMethod.merge(overrides, defaults)
    end

    def to_hash
      Hash[@f_methods.map { |fm| [fm.method_name.to_s, fm.send_to(self)] }]
    end

    alias to_message to_hash

    def self.fields
      # A list of fields that the object should have.
      fail NotImplementedError
    end

    def fields
      @fields ||= self.class.fields
    end
  end
end
