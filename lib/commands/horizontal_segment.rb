require_relative '../commands'
require 'dry-validation'

class Commands::HorizontalSegment
  def initialize(state:, args: nil)
    @state = state.to_a
    @x1 = args[0].to_i
    @x2 = args[1].to_i
    @y = args[2].to_i
    @colour = args[3].to_s
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
    n = @state.size
    m = @state.map(&:size).first.to_i
    validation_results = validation_schema.call( { state: @state,
                                                   x1: @x1,
                                                   x2: @x2,
                                                   y: @y,
                                                   colour: @colour,
                                                   'x1-m': @x1-m,
                                                   'x2-m': @x2-m,
                                                   'y-n': @y-n } )
    raise ArgumentError.new(validation_results.messages) unless validation_results.success?
  end

  def validation_schema
    Dry::Validation.Schema do
      required(:state, :array).filled
      required(:x1, :int).value(gt?: 0)
      required(:x2, :int).value(gt?: 0)
      required(:y, :int).value(gt?: 0)
      required(:'x1-m').value(lteq?: 0)
      required(:'x2-m').value(lteq?: 0)
      required(:'y-n').value(lteq?: 0)
      required(:colour, :string).value(format?: /^[A-Z]$/)
    end
  end
end
