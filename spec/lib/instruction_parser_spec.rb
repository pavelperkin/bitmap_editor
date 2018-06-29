require_relative '../../lib/instruction_parser'

RSpec.describe InstructionParser do
  describe '#new' do
    subject { InstructionParser.new(attrs) }

    context 'with valid params' do
      context 'only line is passed' do
        let(:attrs) { { line: 'S' } }
        it {is_expected.to be_instance_of InstructionParser}
      end

      context 'line and dictionary are passed' do
        let(:attrs) { { line: 'S', dictionary: './lib/instructions.yml' } }
        it {is_expected.to be_instance_of InstructionParser}
      end
    end

    context 'with invalid params' do
      context 'empty string as a line' do
        let(:attrs) { { line: '' } }
        it 'raises an ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'nil as a line' do
        let(:attrs) { { line: nil } }
        it 'raises an ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'empty string as dictionary' do
        let(:attrs) { { line: 'S', dictionary: '' } }
        it 'raises an ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'nil as dictionary' do
        let(:attrs) { { line: 'S', dictionary: nil } }
        it 'raises an ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'wrong file path as dictionary' do
        let(:attrs) { { line: 'S', dictionary: 'some/path/to/some/file.yml' } }
        it 'raises an ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe '#parse' do
    subject { InstructionParser.new(attrs).parse }
    let(:attrs) { { line: 'S' } }
    it { is_expected.to be_instance_of Array }
    its(:first) { is_expected.to eq Commands::ShowBitmap}
  end
end
