require_relative '../commands'
require_relative '../validator'

class Commands::VerticalSegment
  def initialize(state:, args: nil)
    @state = state.to_a
    @x = args[0].to_i
    @y1 = args[1].to_i
    @y2 = args[2].to_i
    @colour = args[3].to_s
    validate!
  end

  def run()
    if @y1 >= @y2
      (@y2-1 .. @y1-1).each do |y|
        @state[y][@x-1] = @colour
      end
    else
      (@y1-1 .. @y2-1).each do |y|
        @state[y][@x-1] = @colour
      end
    end
    @state
  end

  private

  def validate!
    raise ArgumentError unless Validator.new(obj: @state, rules: { class: Array, empty?: false }).valid?
    n = @state.size
    m = @state.first.size
    raise ArgumentError unless Validator.new(obj: @x, rules: { integer?: true, positive?: true }).valid?
    raise ArgumentError unless Validator.new(obj: @x-m, rules: { positive?: false }).valid?
    raise ArgumentError unless Validator.new(obj: @y1, rules: { integer?: true, positive?: true }).valid?
    raise ArgumentError unless Validator.new(obj: @y1-n, rules: { positive?: false }).valid?
    raise ArgumentError unless Validator.new(obj: @y2, rules: { integer?: true, positive?: true }).valid?
    raise ArgumentError unless Validator.new(obj: @y2-n, rules: { positive?: false }).valid?
    raise ArgumentError unless Validator.new(obj: @colour, rules: { empty?: false }).valid?
    raise ArgumentError unless Validator.new(obj: @colour.size - 1, rules: { zero?: true }).valid?
    raise ArgumentError unless Validator.new(obj: @colour, rules: { capitalize: @colour }).valid?
  end
end
