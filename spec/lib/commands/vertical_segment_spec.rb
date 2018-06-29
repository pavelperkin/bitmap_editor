require_relative "../../../lib/commands/vertical_segment"

RSpec.describe Commands::VerticalSegment do
  describe '#new' do
    subject { Commands::VerticalSegment.new(state: state, args: args) }
    let(:state) { [['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']] }
    let(:x) { 3 }
    let(:y1) { 1 }
    let(:y2) { 3 }
    let(:colour) { 'A' }
    let(:args) { [x, y1, y2, colour] }

    it { is_expected.to be_instance_of(Commands::VerticalSegment) }

    context 'valid attributes' do
      context 'x == 1' do
        let(:x) { 1 }
        it { is_expected.to be_instance_of(Commands::VerticalSegment) }
      end

      context 'y1 == 1' do
        let(:y1) { 1 }
        it { is_expected.to be_instance_of(Commands::VerticalSegment) }
      end

      context 'y2 == 1' do
        let(:y2) { 1 }
        it { is_expected.to be_instance_of(Commands::VerticalSegment) }
      end

      context 'x == bitmap size' do
        let(:x) { 3 }
        it { is_expected.to be_instance_of(Commands::VerticalSegment) }
      end

      context 'y1 == bitmap size' do
        let(:y1) { 4 }
        it { is_expected.to be_instance_of(Commands::VerticalSegment) }
      end

      context 'y2 == bitmap size' do
        let(:y2) { 4 }
        it { is_expected.to be_instance_of(Commands::VerticalSegment) }
      end

      context 'colour is one capital letter' do
        let(:colour) { 'K' }
        it { is_expected.to be_instance_of(Commands::VerticalSegment) }
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

        context 'y1 < 0 ' do
          let(:y1) { -1 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'y2 < 0 ' do
          let(:y2) { -1 }
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

        context 'y1 == 0 ' do
          let(:y1) { 0 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'y2 == 0 ' do
          let(:y2) { 0 }
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

        context 'y1 > bitmap size' do
          let(:y1) { 5 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'y2 > bitmap size' do
          let(:y2) { 5 }
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
    subject { Commands::VerticalSegment.new(state: state, args: args).run }
    let(:state) { [['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']] }
    let(:colour) { 'A' }
    let(:args) { [x, y1, y2, colour] }

    context 'left top corner' do
      let(:x) { 1 }
      let(:y1) { 1 }
      let(:y2) { 1 }
      it { is_expected.to match [['A', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']] }
    end

    context 'right top corner' do
      let(:x) { 3 }
      let(:y1) { 1 }
      let(:y2) { 1 }
      it { is_expected.to match [['O', 'O', 'A'], ['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']] }
    end

    context 'left bottom corner' do
      let(:x) { 3 }
      let(:y1) { 4 }
      let(:y2) { 4 }
      it { is_expected.to match [['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'A']] }
    end

    context 'right bottom corner' do
      let(:x) { 1 }
      let(:y1) { 4 }
      let(:y2) { 4 }
      it { is_expected.to match [['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O'], ['A', 'O', 'O']] }
    end

    context 'left line' do
      let(:x) { 1 }
      let(:y1) { 1 }
      let(:y2) { 4 }
      it { is_expected.to match [['A', 'O', 'O'], ['A', 'O', 'O'], ['A', 'O', 'O'], ['A', 'O', 'O']] }
    end

    context 'left line 2' do
      let(:x) { 1 }
      let(:y1) { 4 }
      let(:y2) { 1 }
      it { is_expected.to match [['A', 'O', 'O'], ['A', 'O', 'O'], ['A', 'O', 'O'], ['A', 'O', 'O']] }
    end

    context 'right line' do
      let(:x) { 3 }
      let(:y1) { 1 }
      let(:y2) { 4 }
      it { is_expected.to match [['O', 'O', 'A'], ['O', 'O', 'A'], ['O', 'O', 'A'], ['O', 'O', 'A']] }
    end

    context 'right line 2' do
      let(:x) { 3 }
      let(:y1) { 4 }
      let(:y2) { 1 }
      it { is_expected.to match [['O', 'O', 'A'], ['O', 'O', 'A'], ['O', 'O', 'A'], ['O', 'O', 'A']] }
    end

    context 'segment' do
      let(:x) { 2 }
      let(:y1) { 3 }
      let(:y2) { 2 }
      it { is_expected.to match [['O', 'O', 'O'], ['O', 'A', 'O'], ['O', 'A', 'O'], ['O', 'O', 'O']] }
    end
  end
end
