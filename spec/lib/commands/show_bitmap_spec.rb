require_relative "../../../lib/commands/show_bitmap"

RSpec.describe Commands::ShowBitmap do
  describe '#new' do
    subject { Commands::ShowBitmap.new(state: state) }
    let(:state) { [] }
    it { is_expected.to be_instance_of(Commands::ShowBitmap) }

    context 'nil state' do
      let(:state) { nil }

      it { is_expected.to be_instance_of(Commands::ShowBitmap) }
    end
  end

  describe '#run' do
    subject { Commands::ShowBitmap.new(state: state).run }

    context 'empty state' do
      let(:state) { [] }
      it { is_expected.to be_instance_of Array }
      it { is_expected.to be_empty }
      it { is_expected.to match [] }
      it { expect { subject }.to output.to_stdout }
    end

    context 'valid states' do
      let(:state) { [['O', 'O', 'O'], ['O', 'Z', 'A']] }
      it { is_expected.to be_instance_of Array }
      it { is_expected.not_to be_empty }
      it { is_expected.to match [['O', 'O', 'O'], ['O', 'Z', 'A']] }
      it { expect { subject }.to output.to_stdout }
    end
  end
end
