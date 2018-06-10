require 'command'
require 'validator'

class HorizontalSegment < Command
  def initialize(state: ,x1: ,x2: ,y: ,colour: )
    @state = state.to_a
    @x1 = x1.to_i
    @x2 = x2.to_i
    @y = y.to_i
    @colour = colour.to_s
    validate!
  end

  def run()
    if @x1 >= @x2
      (@x2-1 .. @x1-1).each do |x|
        @state[@y-1][x] = @colour
      end
    else
      (@x1-1 .. @x2-1).each do |x|
        @state[@y-1][x] = @colour
      end
    end
    @state
  end

  private

  def validate!
    raise ArgumentError unless Validator.new(obj: @state, rules: { class: Array, empty?: false }).valid?
    n = @state.size
    m = @state.first.size
    raise ArgumentError unless Validator.new(obj: @y, rules: { integer?: true, positive?: true }).valid?
    raise ArgumentError unless Validator.new(obj: @y-n, rules: { positive?: false }).valid?
    raise ArgumentError unless Validator.new(obj: @x1, rules: { integer?: true, positive?: true }).valid?
    raise ArgumentError unless Validator.new(obj: @x1-m, rules: { positive?: false }).valid?
    raise ArgumentError unless Validator.new(obj: @x2, rules: { integer?: true, positive?: true }).valid?
    raise ArgumentError unless Validator.new(obj: @x2-m, rules: { positive?: false }).valid?
    raise ArgumentError unless Validator.new(obj: @colour, rules: { empty?: false }).valid?
    raise ArgumentError unless Validator.new(obj: @colour.size - 1, rules: { zero?: true }).valid?
    raise ArgumentError unless Validator.new(obj: @colour, rules: { capitalize: @colour }).valid?
  end
end
