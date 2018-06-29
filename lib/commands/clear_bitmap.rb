require_relative '../commands'
require_relative '../validator'

class Commands::ClearBitmap
  attr_reader :state

  def initialize(state:, args: nil)
    @state = state
    validate!
  end

  def run()
    n = @state.size
    m = @state.first.size
    Array.new(n, Array.new(m, 'O'))
  end

  private

  def validate!
    raise ArgumentError unless Validator.new(obj: @state, rules: { class: Array }).valid?
  end
end
