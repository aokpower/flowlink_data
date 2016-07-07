require_relative '../../../lib/flowlink_data/objectbase'

class TestBase < Flowlink::ObjectBase
  def self.fields
    [:foo, :bar]
  end

  def initialize(*overrides)
    fields.each do |f|
      self.class.send(:define_method, f.to_s) { 1 }
    end
    super
  end

  def baz(n = 0)
    n == 1
  end

  def biz
    yield
  end
end

RSpec.describe Flowlink do
  describe Flowlink::ObjectBase do
    # include in Flowlink::<BusinessObject> classes, such as Product.

    context '#new args:' do
      # Not sure I want to enable old style.
      # it 'can use old array input style' do
      #   override = [:baz, [1]]
      #   actual   = TestBase.new(override)
      #   expect(actual.to_hash['baz']).to eq true
      # end

      it 'can add a new call' do
        override = FieldMethod.new :baz, 1
        actual   = TestBase.new(override)
        expect(actual.to_hash['baz']).to eq true
      end

      it 'can override an existing call' do
        override = FieldMethod.new :foo, 1
        expect { TestBase.new(override).to_hash }.to raise_error(ArgumentError)
      end

      it 'can add a block' do
        override = FieldMethod.new :biz, proc { 1 }
        actual   = TestBase.new(override)
        expect(actual.to_hash['biz']).to eq 1
      end
    end

    context '#to_message' do
      subject { base.to_message }
      let(:keys) { subject.keys }
      let(:base) { TestBase.new }

      it { is_expected.to be_kind_of(Hash) }

      it 'keys are strings' do
        expect(keys.all? { |k| k.kind_of?(String) }).to eq(true)
      end

      it 'has keys matching fields' do
        expect(keys.sort).to eq(base.fields.map(&:to_s).sort)
      end

    end
  end
end
