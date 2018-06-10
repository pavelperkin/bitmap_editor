require 'command'
require 'validator'

class InitBitmap < Command
  attr_reader :state

  def initialize(m: , n: )
    @m = m.to_i
    @n = n.to_i
    validate!
    @state = Array.new(@n, Array.new(@m, 'O'))
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
