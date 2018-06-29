require_relative "../../../lib/commands/init_bitmap"

RSpec.describe Commands::InitBitmap do
  describe '#new' do
    subject { Commands::InitBitmap.new(args: args) }
    let(:m) {3}
    let(:n) {4}
    let(:args) { [m, n] }

    context 'valid params' do
      context 'm = 1 and n = 1' do
        let(:m) { 1 }
        let(:n) { 1 }
        it { is_expected.to be_instance_of(Commands::InitBitmap) }
      end

      context 'm = 250 and n = 250' do
        let(:m) { 250 }
        let(:n) { 250 }
        it { is_expected.to be_instance_of(Commands::InitBitmap) }
      end

      context 'm = 50 and n = 25' do
        let(:m) { 50 }
        let(:n) { 25 }
        it { is_expected.to be_instance_of(Commands::InitBitmap) }
      end
    end

    context 'invalid params' do
      context 'negative params' do
        context 'm is invalid' do
          let(:m) { -42 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'n is invalid' do
          let(:n) { -42 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'm and n are invalid' do
          let(:n) { -42 }
          let(:m) { -41 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end
      end

      context 'zero params' do
        context 'm is invalid' do
          let(:m) { 0 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'n is invalid' do
          let(:n) { 0 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'm and n are invalid' do
          let(:n) { 0 }
          let(:m) { 0 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end
      end

      context '> 250' do
        context 'm is invalid' do
          let(:m) { 251 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'n is invalid' do
          let(:n) { 251 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'm and n are invalid' do
          let(:n) { 251 }
          let(:m) { 251 }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end
      end

      context 'nil params' do
        context 'm is invalid' do
          let(:m) { nil }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'n is invalid' do
          let(:n) { nil }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'm and n are invalid' do
          let(:n) { nil }
          let(:m) { nil }
          it 'raises an ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end
      end
    end
  end

  describe '#run' do
    subject { Commands::InitBitmap.new(args: args).run }
      let(:m) { 3 }
      let(:n) { 5 }
      let(:args) { [m, n] }

      it { is_expected.to be_instance_of Array }
      it { is_expected.not_to be_empty }
      it { is_expected.to match [['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']] }
  end
end
