require_relative "../../lib/bitmap_editor"

RSpec.describe BitmapEditor do
  describe '#new' do
    subject { BitmapEditor.new }

    it { is_expected.to be_instance_of(BitmapEditor) }
  end

  describe '#run' do
    subject { described_class.new.run(file_path) }

    context 'file is not provided' do
      context 'file is nil' do
        let(:file_path) { nil }
        it { is_expected.to be_nil }
      end

      context 'file is empty string' do
        let(:file_path) { '' }
        it { is_expected.to be_nil }
      end

      context 'file is not a real file path' do
        let(:file_path) { '/some/not/real/file' }
        it { is_expected.to be_nil }
      end
    end

    context 'file is provided' do
      context 'empty file' do
        let(:file_path) { 'spec/support/input_files/empty_file.txt' }
        it { is_expected.to be_empty }
      end

      context 'file starts not with Init' do
        let(:file_path) { 'spec/support/input_files/invalid_file.txt' }
        it 'raises ArgumentError' do
          expect { subject }.to raise_error(SystemExit)
        end
      end

      context 'init_bitmap only' do
        let(:file_path) { 'spec/support/input_files/init_bitmap_only_file.txt' }
        it { is_expected.not_to be_empty }
        it { is_expected.to be_instance_of Array }
        its(:size) { is_expected.to eq 6 }
        its(:sample) { is_expected.to be_instance_of Array }
        its('sample.size') { is_expected.to eq 5 }
        its('sample.sample') { is_expected.to eq 'O' }
      end

      context 'case from test' do
        let(:file_path) { 'spec/support/input_files/test_example.txt' }
        let(:expected_res) { [['O','O','O','O','O'], ['O','O','Z','Z','Z'], ['A','W','O','O','O'], ['O','W','O','O','O'], ['O','W','O','O','O'], ['O','W','O','O','O']]}
        it { is_expected.not_to be_empty }
        it { is_expected.to be_instance_of Array }
        its(:size) { is_expected.to eq 6 }
        its(:sample) { is_expected.to be_instance_of Array }
        its('sample.size') { is_expected.to eq 5 }
        it { is_expected.to match expected_res}
      end
    end
  end
end
