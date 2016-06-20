require_relative '../../../lib/flowlink_data.rb'

class TestBase < Flowlink::ObjectBase
  def self.fields
    [:foo, :bar]
  end

  def initialize
    fields.each do |f|
      self.class.send(:define_method, f.to_s) { 1 }
    end
  end
  
  def baz(n = 0)
    n == 1
  end
end

RSpec.describe Flowlink do
  describe Flowlink::Product do
    # An abstract class that raises NotImplementedError for all required
    # Flowlink product fields.

    it 'has required fields as methods' do
      subject.fields.each do |field|
        expect(subject.methods.include?(field)).to be(true), "expected a defined method named #{field}."
      end
    end

    it 'raises NotImplementedErrors for all field methods' do
      subject.fields.each do |field|
        expect { eval "subject.#{field}" }.to raise_error(NotImplementedError),
                                              "expected Product##{field} to raise NotImplementedError."
      end
    end

    # describe '#fields'
  end
end
