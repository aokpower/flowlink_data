class FieldMethod
  attr_accessor :method_name, :args

  def self.multi_new(methods)
    methods.map do |m|
      m = [m].flatten
      FieldMethod.new(m.shift, m)
    end
  end

  def self.merge(overrides, original)
    overrides.inject(original) { |a, e| e.merge(a) }
  end

  def initialize(method_name, *args)
    @method_name = method_name.to_sym
    @args        = args.to_a.flatten
  end

  def merge(list)
    list.delete_if { |o_fm| o_fm.method_name == method_name }
    list << self
  end

  def to_a
    [method_name] + args
  end
end

module Flowlink
  class ObjectBase
    # Base class for any Flowlink objects. Child classes should implement
    # self.fields internally.

    def to_hash(*overrides)
      overrides = FieldMethod.multi_new(overrides)
      defaults  = FieldMethod.multi_new(fields)
      f_methods = FieldMethod.merge(overrides, defaults)

      Hash[f_methods.map { |f| [f.method_name.to_s, send(*f.to_a)] }]
    end

    alias_method to_message to_hash

    def self.fields
      # A list of fields that the object should have.
      fail NotImplementedError
    end

    def fields
      # TODO: @fields ||= self.class.fields ???
      self.class.fields
    end
  end
end
