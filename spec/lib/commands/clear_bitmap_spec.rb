require_relative "../../../lib/commands/clear_bitmap"

RSpec.describe Commands::ClearBitmap do
  describe '#new' do
    subject { Commands::ClearBitmap.new(state: state) }
    let(:state) { [] }
    it { is_expected.to be_instance_of(Commands::ClearBitmap) }

    context 'nil state' do
      let(:state) { nil }
      it { is_expected.to be_instance_of(Commands::ClearBitmap) }
    end
  end

  describe '#run' do
    subject { Commands::ClearBitmap.new(state: state).run }
    context 'valid params' do
        let(:state) { [['A', 'B', 'C'],
                       ['D', 'E', 'F'],
                       ['X', 'Y', 'Z']]}

        it { is_expected.to be_instance_of Array }
        it { is_expected.not_to be_empty }
        it { is_expected.to match [['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']] }
    end

    context 'empty state' do
      let(:state) { [] }

      it { is_expected.to be_instance_of Array }
      it { is_expected.to be_empty }
    end
  end
end
