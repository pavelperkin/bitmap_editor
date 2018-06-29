require_relative '../commands'
require_relative '../validator'

class Commands::PaintPixel
  def initialize(state:, args:)
    @state = state.to_a
    @x = args[0].to_i
    @y = args[1].to_i
    @colour = args[2].to_s
    validate!
  end

  def run()
    @state[@y-1][@x-1] = @colour
    @state
  end

  private

  def validate!
    raise ArgumentError unless Validator.new(obj: @state, rules: { class: Array, empty?: false }).valid?
    n = @state.size
    m = @state.first.size
    raise ArgumentError unless Validator.new(obj: @x, rules: { integer?: true, positive?: true }).valid?
    raise ArgumentError unless Validator.new(obj: @x-m, rules: { positive?: false }).valid?
    raise ArgumentError unless Validator.new(obj: @y, rules: { integer?: true, positive?: true }).valid?
    raise ArgumentError unless Validator.new(obj: @y-n, rules: { positive?: false }).valid?
    raise ArgumentError unless Validator.new(obj: @colour, rules: { empty?: false }).valid?
    raise ArgumentError unless Validator.new(obj: @colour.size - 1, rules: { zero?: true }).valid?
    raise ArgumentError unless Validator.new(obj: @colour, rules: { capitalize: @colour }).valid?
  end
end
