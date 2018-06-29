require_relative "../../../lib/commands/paint_pixel"

RSpec.describe Commands::PaintPixel do
  describe '#new' do
    subject { Commands::PaintPixel.new(state: state, args: args) }
    let(:state) { [['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']] }
    let(:x) { 3 }
    let(:y) { 4 }
    let(:colour) { 'A' }
    let(:args) { [x, y, colour] }
    it { is_expected.to be_instance_of(Commands::PaintPixel) }

    context 'valid attributes' do
      context 'x == 1' do
        let(:x) { 1 }
        it { is_expected.to be_instance_of(Commands::PaintPixel) }
      end

      context 'y == 1' do
        let(:y) { 1 }
        it { is_expected.to be_instance_of(Commands::PaintPixel) }
      end

      context 'x == bitmap size' do
        let(:x) { 3 }
        it { is_expected.to be_instance_of(Commands::PaintPixel) }
      end

      context 'y == bitmap size' do
        let(:y) { 4 }
        it { is_expected.to be_instance_of(Commands::PaintPixel) }
      end

      context 'colour is one capital letter' do
        let(:colour) { 'K' }
        it { is_expected.to be_instance_of(Commands::PaintPixel) }
      end
    end

    context 'invalide attributes' do
      context 'invalid state' do
        let(:state) { nil }
        it 'raises an ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'empty state' do
        let(:state) { [] }
        it 'raises an ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'invalid coordinates' do
        context 'x < 0 ' do
          let(:x) { -1 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'y < 0 ' do
          let(:y) { -1 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'x == 0 ' do
          let(:x) { 0 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'y == 0 ' do
          let(:y) { 0 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'x > bitmap size ' do
          let(:x) { 4 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'y > bitmap size' do
          let(:y) { 5 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'colour is nil' do
          let(:colour) { nil }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'colour is empty' do
          let(:colour) { '' }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'colour is longer than one char' do
          let(:colour) { 'AB' }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'colour is a lowercase char' do
          let(:colour) { 'a' }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end
      end
    end
  end

  describe '#run' do
    subject { Commands::PaintPixel.new(state: state, args: args).run }
    let(:state) { [['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']] }
    let(:colour) { 'A' }
    let(:args) { [x, y, colour] }

    context 'left top corner' do
      let(:x) { 1 }
      let(:y) { 1 }
      it { is_expected.to match [['A', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']] }
    end

    context 'right top corner' do
      let(:x) { 3 }
      let(:y) { 1 }
      it { is_expected.to match [['O', 'O', 'A'], ['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']] }
    end

    context 'left bottom corner' do
      let(:x) { 3 }
      let(:y) { 4 }
      it { is_expected.to match [['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'A']] }
    end

    context 'right bottom corner' do
      let(:x) { 1 }
      let(:y) { 4 }
      it { is_expected.to match [['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O'], ['A', 'O', 'O']] }
    end
  end
end
