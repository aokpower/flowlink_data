module Flowlink
  class ObjectBase
    # Base class for any Flowlink objects. Child classes should implement
    # self.fields internally.

    def to_hash
      # Put values of calling field methods on self into a hash
      Hash[fields.map { |f| [f.to_s, send(f)] }]
    end

    alias_method to_message to_hash

    def self.fields
      # A list of fields that the object should have.
      fail NotImplementedError
    end

    def fields
      self.class.fields
    end
  end
end


