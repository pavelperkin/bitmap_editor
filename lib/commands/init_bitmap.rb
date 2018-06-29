require_relative '../commands'
require_relative '../validator'

class Commands::InitBitmap
  attr_reader :state

  def initialize(state: nil, args: [1, 1])
    @m = args.first.to_i
    @n = args.last.to_i
    validate!
    @state = Array.new(@n){ Array.new(@m, 'O') }
  end

  alias :run :state

  private

  def validate!
    raise ArgumentError unless Validator.new(obj: @m, rules: { integer?: true, positive?: true }).valid?
    raise ArgumentError unless Validator.new(obj: @n, rules: { integer?: true, positive?: true }).valid?
    raise ArgumentError unless Validator.new(obj: @m-250, rules: { positive?: false }).valid?
    raise ArgumentError unless Validator.new(obj: @n-250, rules: { positive?: false }).valid?
  end
end
