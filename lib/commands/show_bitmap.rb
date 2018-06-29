require_relative '../commands'
require_relative '../validator'

class Commands::ShowBitmap
  def initialize(state:, args: nil)
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
