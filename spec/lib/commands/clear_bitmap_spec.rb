require_relative "../../../lib/commands/clear_bitmap"

RSpec.describe Commands::ClearBitmap do
  describe '#new' do
    subject { Commands::ClearBitmap.new(state: state) }
    let(:state) { [] }
    it { is_expected.to be_instance_of(Commands::ClearBitmap) }

    context 'invalid state' do
      let(:state) { nil }

      it 'raises an ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#run' do
    subject { Commands::ClearBitmap.new(state: state).run }
      let(:state) { [['A', 'B', 'C'],
                     ['D', 'E', 'F'],
                     ['X', 'Y', 'Z']]}

      it { is_expected.to be_instance_of Array }
      it { is_expected.not_to be_empty }
      it { is_expected.to match [['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']] }
  end
end
