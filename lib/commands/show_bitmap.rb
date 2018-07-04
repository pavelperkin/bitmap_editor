require_relative '../commands'
require 'dry-validation'

class Commands::ShowBitmap
  def initialize(state:, args: nil)
    @state = state.to_a
    validate!
  end

  def run()
    puts @state.map(&:join).join("\n")
    @state
  end

  private

  def validate!
    raise ArgumentError unless validation_schema.call( { state: @state } ).success?
  end

  def validation_schema
    Dry::Validation.Schema do
      required(:state, :array)
    end
  end
end
