require 'command'
require 'validator'

class ShowBitmap < Command
  def initialize(state:)
    @state = state
    validate!
  end

  def run()
    puts @state.map(&:join).join("\n")
    @state
  end

  private

  def validate!
    raise ArgumentError unless Validator.new(obj: @state, rules: { class: Array }).valid?
  end
end
