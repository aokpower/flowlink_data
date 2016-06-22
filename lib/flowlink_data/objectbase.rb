class FieldMethod
  attr_reader :method_name, :args, :block

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
    @method_name  = method_name.to_sym
    @args         = args.to_a.flatten
    @block, @args = @args.partition { |arg| arg.is_a? Proc }
    @block = @block[0]
  end

  def merge(list)
    # This will put itself into a list of other FieldMethods and overwrite
    # an existing FM with the same name
    list.delete_if { |o_fm| o_fm.method_name == method_name }
    list << self
  end

  def to_a
    [method_name] + args
  end

  def send_to(sendable)
    # can't just splat because procs have to be treated with kids gloves >:/
    # TODO: use #to_a and reduce cases/enforce SRP on regular arg assembley
    case 
    when !block && !args.empty?
      sendable.send(method_name, *args)
    when block && args.empty?
      sendable.send(method_name, &block)
    when block && !args.empty?
      sendable.send(method_name, *args, &block)
    when !block && args.empty?
      sendable.send(method_name)
    end
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

      Hash[f_methods.map { |fm| [fm.method_name.to_s, fm.send_to(self)] }]
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
