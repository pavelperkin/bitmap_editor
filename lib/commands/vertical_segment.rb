require 'command'
require 'validator'

class VerticalSegment < Command
  def initialize(state: ,x: ,y1: ,y2: ,colour: )
    @state = state.to_a
    @x = x.to_i
    @y1 = y1.to_i
    @y2 = y2.to_i
    @colour = colour.to_s
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
