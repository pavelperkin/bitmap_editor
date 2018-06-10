require_relative "../../../lib/commands/horizontal_segment"

RSpec.describe HorizontalSegment do
  describe '#new' do
    subject { HorizontalSegment.new(state: state, x1: x1, x2: x2, y: y, colour: colour) }
    let(:state) { [['O', 'O', 'O', 'O'], ['O', 'O', 'O', 'O'], ['O', 'O', 'O', 'O']] }
    let(:x1) { 1 }
    let(:x2) { 3 }
    let(:y) { 1 }
    let(:colour) { 'A' }

    it { is_expected.to be_instance_of(HorizontalSegment) }
    it { is_expected.to be_kind_of(Command) }

    context 'valid attributes' do
      context 'y == 1' do
        let(:y) { 1 }
        it { is_expected.to be_instance_of(HorizontalSegment) }
        it { is_expected.to be_kind_of(Command) }
      end

      context 'x1 == 1' do
        let(:x1) { 1 }
        it { is_expected.to be_instance_of(HorizontalSegment) }
        it { is_expected.to be_kind_of(Command) }
      end

      context 'x2 == 1' do
        let(:y2) { 1 }
        it { is_expected.to be_instance_of(HorizontalSegment) }
        it { is_expected.to be_kind_of(Command) }
      end

      context 'y == bitmap size' do
        let(:y) { 3 }
        it { is_expected.to be_instance_of(HorizontalSegment) }
        it { is_expected.to be_kind_of(Command) }
      end

      context 'x1 == bitmap size' do
        let(:x1) { 4 }
        it { is_expected.to be_instance_of(HorizontalSegment) }
        it { is_expected.to be_kind_of(Command) }
      end

      context 'x2 == bitmap size' do
        let(:x2) { 4 }
        it { is_expected.to be_instance_of(HorizontalSegment) }
        it { is_expected.to be_kind_of(Command) }
      end

      context 'colour is one capital letter' do
        let(:colour) { 'K' }
        it { is_expected.to be_instance_of(HorizontalSegment) }
        it { is_expected.to be_kind_of(Command) }
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
        context 'y < 0 ' do
          let(:y) { -1 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'x1 < 0 ' do
          let(:x1) { -1 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'x2 < 0 ' do
          let(:x2) { -1 }
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

        context 'x1 == 0 ' do
          let(:x1) { 0 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'x2 == 0 ' do
          let(:x2) { 0 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'y > bitmap size ' do
          let(:y) { 4 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'x1 > bitmap size' do
          let(:x1) { 5 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'x2 > bitmap size' do
          let(:x2) { 5 }
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
    subject { HorizontalSegment.new(state: state, x1: x1, x2: x2, y: y, colour: colour).run }
    let(:state) { [['O', 'O', 'O', 'O'], ['O', 'O', 'O', 'O'], ['O', 'O', 'O', 'O']] }
    let(:colour) { 'A' }

    context 'left top corner' do
      let(:x1) { 1 }
      let(:x2) { 1 }
      let(:y) { 1 }
      it { is_expected.to match [['A', 'O', 'O', 'O'], ['O', 'O', 'O', 'O'], ['O', 'O', 'O', 'O']] }
    end

    context 'right top corner' do
      let(:y) { 1 }
      let(:x1) { 4 }
      let(:x2) { 4 }
      it { is_expected.to match [['O', 'O', 'O', 'A'], ['O', 'O', 'O', 'O'], ['O', 'O', 'O', 'O']] }
    end

    context 'left bottom corner' do
      let(:y) { 3 }
      let(:x1) { 1 }
      let(:x2) { 1 }
      it { is_expected.to match [['O', 'O', 'O', 'O'], ['O', 'O', 'O', 'O'], ['A', 'O', 'O', 'O']] }
    end

    context 'right bottom corner' do
      let(:y) { 3 }
      let(:x1) { 4 }
      let(:x2) { 4 }
      it { is_expected.to match [['O', 'O', 'O', 'O'], ['O', 'O', 'O', 'O'], ['O', 'O', 'O', 'A']] }
    end

    context 'top line' do
      let(:y) { 1 }
      let(:x1) { 1 }
      let(:x2) { 4 }
      it { is_expected.to match [['A', 'A', 'A', 'A'], ['O', 'O', 'O', 'O'], ['O', 'O', 'O', 'O']] }
    end

    context 'top line 2' do
      let(:y) { 1 }
      let(:x1) { 4 }
      let(:x2) { 1 }
      it { is_expected.to match [['A', 'A', 'A', 'A'], ['O', 'O', 'O', 'O'], ['O', 'O', 'O', 'O']] }
    end

    context 'bottom line' do
      let(:y) { 3 }
      let(:x1) { 1 }
      let(:x2) { 4 }
      it { is_expected.to match [['O', 'O', 'O', 'O'], ['O', 'O', 'O', 'O'], ['A', 'A', 'A', 'A']] }
    end

    context 'bottom line 2' do
      let(:y) { 3 }
      let(:x1) { 4 }
      let(:x2) { 1 }
      it { is_expected.to match [['O', 'O', 'O', 'O'], ['O', 'O', 'O', 'O'], ['A', 'A', 'A', 'A']] }
    end

    context 'segment' do
      let(:y) { 2 }
      let(:x1) { 3 }
      let(:x2) { 2 }
      it { is_expected.to match [['O', 'O', 'O', 'O'], ['O', 'A', 'A', 'O'], ['O', 'O', 'O', 'O']] }
    end
  end
end
