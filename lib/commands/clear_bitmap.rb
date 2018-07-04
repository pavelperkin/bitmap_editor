require_relative '../commands'
require 'dry-validation'

class Commands::ClearBitmap
  def initialize(state:, args: nil)
    @state = state
    validate!
  end

  def run()
    n = @state.size.to_i
    m = @state.map(&:size).first.to_i
    Array.new(n, Array.new(m, 'O'))
  end

  private

  def validate!
    validation_results = validation_schema.call( { state: @state } )
    raise ArgumentError.new(validation_results.messages(full: true).values.join("\n")) unless validation_results.success?
  end

  def validation_schema
    Dry::Validation.Schema do
      required(:state, :array)
    end
  end
end
