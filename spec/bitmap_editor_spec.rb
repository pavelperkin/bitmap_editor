require_relative "../lib/bitmap_editor"

RSpec.describe BitmapEditor do
  describe '#new' do
    subject { BitmapEditor.new }

    it { is_expected.to be_instance_of(BitmapEditor) }
  end
end
