require_relative '../commands'
require 'dry-validation'

class Commands::InitBitmap
  def initialize(state: nil, args: [1, 1])
    @m = args.first.to_i
    @n = args.last.to_i
    validate!
    @state = Array.new(@n){ Array.new(@m, 'O') }
  end

  def run
    @state
  end

  private

  def validate!
    validation_results = validation_schema.call( {m: @m, n: @n} )
    raise ArgumentError.new(validation_results.messages(full: true).values.join("\n")) unless validation_results.success?
  end

  def validation_schema
    Dry::Validation.Schema do
      required(:m, :integer) { gt?(0) & lteq?(250) }
      required(:n, :integer) { gt?(0) & lteq?(250) }
    end
  end
end
