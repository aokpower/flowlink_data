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
    @block        = @block[0]
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
    # we can't splat procs, so this is necessary
    # TODO: use #to_a and reduce cases/enforce SRP on regular arg assembler
    case
    when block && args.empty?
      sendable.send(method_name, &block)
    when block && !args.empty?
      sendable.send(method_name, *args, &block)
    when !block && args.empty?
      sendable.send(method_name)
    when !block && !args.empty?
      sendable.send(method_name, *args)
    end
  end
end
