require_relative "../../lib/command"

RSpec.describe Command do
  describe '#new' do
    subject { Command.new }

    it { is_expected.to be_instance_of(Command) }
  end

  describe '#run' do
    subject { Command.new.run }

    it 'raises an NotImplementedError' do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end
end
