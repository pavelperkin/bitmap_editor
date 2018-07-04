require_relative '../commands'
require 'dry-validation'

class Commands::PaintPixel
  def initialize(state:, args:)
    @state = state.to_a
    @x = args[0].to_i
    @y = args[1].to_i
    @colour = args[2].to_s
    validate!
  end

  def run()
    @state[@y-1][@x-1] = @colour
    @state
  end

  private

  def validate!
    n = @state.size
    m = @state.map(&:size).first.to_i
    validation_results = validation_schema.call( { state: @state,
                                                   x: @x,
                                                   y: @y,
                                                   colour: @colour,
                                                   'x-m': @x-m,
                                                   'y-n': @y-n } )
    raise ArgumentError.new(validation_results.messages) unless validation_results.success?
  end

  def validation_schema
    Dry::Validation.Schema do
      required(:state, :array).filled
      required(:x, :int).value(gt?: 0)
      required(:y, :int).value(gt?: 0)
      required(:'x-m').value(lteq?: 0)
      required(:'y-n').value(lteq?: 0)
      required(:colour, :string).value(format?: /^[A-Z]$/)
    end
  end
end
