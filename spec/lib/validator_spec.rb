require_relative '../../lib/validator'

RSpec.describe Validator do
  describe '#new' do
    context 'with rules and object' do
      subject { Validator.new(obj: obj, rules: rules) }
      let(:obj) { 42 }
      let(:rules) { {} }

      it { is_expected.to be_instance_of Validator}
    end

    context 'without object' do
      subject { Validator.new(rules: rules) }
      let(:rules) { {} }

      it 'raises ArgumentError if object was not passed' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'without rules' do
      subject { Validator.new(obj: obj) }
      let(:obj) { 42 }
      it { is_expected.to be_instance_of Validator}
    end
  end

  describe '#validate'  do
    subject { Validator.new(obj: obj, rules: rules).validate }

    context 'for basic classes' do
      context 'String' do
        context 'without rules' do
          let(:rules) { {} }
          let(:obj) { '' }
          its(:errors) { is_expected.to be_empty }
        end

        context 'with one rule' do
          let(:rules) { { empty?: true } }

          context 'valid' do
            let(:obj) { '' } #empty: true
            its(:errors) { is_expected.to be_empty }
          end

          context 'invalid' do
            let(:obj) { 'some string' } #empty: false
            its(:errors) { is_expected.not_to be_empty }
            its(:errors) { is_expected.to eq ['Method empty? should return true'] }
          end
        end

        context 'with multiple rules' do
          let(:rules) { { empty?: false, length: 4 } }

          context 'valid' do
            let(:obj) { 'ruby' } # empty: false, length: 4
            its(:errors) { is_expected.to be_empty }
          end

          context 'invalid' do
            context 'one rule is invalid' do
              let(:obj) { 'ruby-ruby' } #empty: false, length: 9
              its(:errors) { is_expected.not_to be_empty }
              its(:errors) { is_expected.to eq ['Method length should return 4'] }
            end

            context 'all rules are invalid' do
              let(:obj) { '' } #empty: true, length: 0
              its(:errors) { is_expected.not_to be_empty }
              its(:errors) { is_expected.to eq ['Method empty? should return false', 'Method length should return 4'] }
            end
          end
        end
      end

      context 'Integer' do
        context 'without rules' do
          let(:rules) { {} }
          let(:obj) { 42 }
          its(:errors) { is_expected.to be_empty }
        end

        context 'with one rule' do
          let(:rules) { { zero?: true } }

          context 'valid' do
            let(:obj) { 0 } #zero: true
            its(:errors) { is_expected.to be_empty }
          end

          context 'invalid' do
            let(:obj) { 42 } #zero: false
            its(:errors) { is_expected.not_to be_empty }
            its(:errors) { is_expected.to eq ['Method zero? should return true'] }
          end
        end

        context 'with multiple rules' do
          let(:rules) { { zero?: false, to_s: '42' } }

          context 'valid' do
            let(:obj) { 42 } #zero: false, to_s: '42'
            its(:errors) { is_expected.to be_empty }
          end

          context 'invalid' do
            context 'one rule is invalid' do
              let(:obj) { 41 } #zero: false, to_s: '41'
              its(:errors) { is_expected.not_to be_empty }
              its(:errors) { is_expected.to eq ['Method to_s should return 42'] }
            end

            context 'all rules are invalid' do
              let(:obj) { 0 } #zero: true, to_s: '0'
              its(:errors) { is_expected.not_to be_empty }
              its(:errors) { is_expected.to eq ['Method zero? should return false', 'Method to_s should return 42'] }
            end
          end
        end
      end
    end
  end

  describe '#valid?' do
    subject { Validator.new(obj: obj,rules: rules).valid? }

    context 'for basic classes' do
      context 'String' do
        context 'with one rule' do
          let(:rules) { { empty?: true } }

          context 'valid' do
            let(:obj) { '' } #empty: true
            it { is_expected.to be_truthy }
          end

          context 'invalid' do
            let(:obj) { 'some string' } #empty: false
            it { is_expected.to be_falsey }
          end
        end

        context 'with multiple rules' do
          let(:rules) { { empty?: false, length: 4 } }

          context 'valid' do
            let(:obj) { 'ruby' } # empty: false, length: 4
            it { is_expected.to be_truthy }
          end

          context 'invalid' do
            context 'one rule is invalid' do
              let(:obj) { 'ruby-ruby' } #empty: false, length: 9
              it { is_expected.to be_falsey }
            end

            context 'all rules are invalid' do
              let(:obj) { '' } #empty: true, length: 0
              it { is_expected.to be_falsey }
            end
          end
        end
      end

      context 'Integer' do
        context 'with one rule' do
          let(:rules) { { zero?: true } }

          context 'valid' do
            let(:obj) { 0 } #zero: true
            it { is_expected.to be_truthy }
          end

          context 'invalid' do
            let(:obj) { 42 } #zero: false
            it { is_expected.to be_falsey }
          end
        end

        context 'with multiple rules' do
          let(:rules) { { zero?: false, to_s: '42' } }

          context 'valid' do
            let(:obj) { 42 } #zero: false, to_s: '42'
            it { is_expected.to be_truthy }
          end

          context 'invalid' do
            context 'one rule is invalid' do
              let(:obj) { 41 } #zero: false, to_s: '41'
              it { is_expected.to be_falsey }
            end

            context 'all rules are invalid' do
              let(:obj) { 0 } #zero: true, to_s: '0'
              it { is_expected.to be_falsey }
            end
          end
        end
      end
    end
  end

  describe '#valid_file?' do
    subject { Validator.new(obj: obj).valid_file? }
    context 'valid file path passed' do
      context 'object is an existing path' do
        let(:obj) { './validator_spec' }
        it { is_expected.to be_falsey}
      end
    end

    context 'invalid file path passed' do
      context 'object is an unexisting path' do
        let(:obj) { 'some/path/to/some/file.yml' }
        it { is_expected.to be_falsey}
      end

      context 'object is nil' do
        let(:obj) { nil }
        it { is_expected.to be_falsey}
      end
    end
  end
end
