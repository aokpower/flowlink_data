require_relative '../../../lib/flowlink_data/field_method'

# TODO: change FieldMethod.new to take a hash
# TODO: per instance FieldMethod only effect #to_hash, #to_message output. bad?
#   Is this really a problem? If you want an individual field, you can 
#   #to_hash[:field], and if you want to call a specific field you do
#   FieldMethod#send_to(product)

FM = Flowlink::FieldMethod # class alias for easier typing

RSpec.describe FM do
  context '#==' do
    context 'can tell if two FM are' do
      it 'equivalent' do
        eq_one = FM.new(:foo)
        eq_two = FM.new(:foo)
        expect(eq_one).to eq eq_two
      end

      it 'different' do
        df_one = FM.new(:foo)
        df_two = FM.new(:bar)
        expect(df_one).to_not eq df_two
      end
    end
  end

  context '#to_a' do
    it 'gives method name, then arguments' do
      # How do you comare procs? In pry proc { 1 } != proc { 1 }
      fm = FM.new(:foo, 'bar')
      expect(fm.to_a).to eq [:foo, 'bar']
    end

    it 'gives block as last element if given' do
      block = proc { 1 }
      fm = FM.new(:foo, block)
      actual = fm.to_a[-1]
      expect(actual).to eq block
    end
  end

  context '.multi_new' do
    it 'creates FM instances from lists of lists' do
      expected = [FM.new(:bar), FM.new(:foo, 1)]
      actual   = FM.multi_new([[:bar], [:foo, 1]])

      expect(actual).to eq expected
    end
  end

  context '#merge' do
    it 'keeps unique methods' do
      override = [FM.new(:baz)]
      original = [FM.new(:foo)]

      actual   = FM.merge(override, original)
      expected = [original[0], override[0]] # order dependant, but you get the idea
      expect(actual).to eq expected
    end

    it 'overrides original methods with new ones' do
      original = FM.multi_new([[:foo], [:bar, 1]])
      override = FM.multi_new([[:foo, 1], [:baz]])
    end
  end

  context '#send_to'
end
