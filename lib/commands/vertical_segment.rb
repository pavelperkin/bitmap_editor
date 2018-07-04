require_relative '../commands'
require 'dry-validation'

class Commands::VerticalSegment
  def initialize(state:, args: nil)
    @state = state.to_a
    @x = args[0].to_i
    @y1 = args[1].to_i
    @y2 = args[2].to_i
    @colour = args[3].to_s
    validate!
  end

  def run()
    if @y1 >= @y2
      (@y2-1 .. @y1-1).each do |y|
        @state[y][@x-1] = @colour
      end
    else
      (@y1-1 .. @y2-1).each do |y|
        @state[y][@x-1] = @colour
      end
    end
    @state
  end

  private

  def validate!
    n = @state.size
    m = @state.map(&:size).first.to_i
    validation_results = validation_schema.call( { state: @state,
                                                   x: @x,
                                                   y1: @y1,
                                                   y2: @y2,
                                                   colour: @colour,
                                                   'x-m': @x-m,
                                                   'y1-n': @y1-n,
                                                   'y2-n': @y2-n } )
    raise ArgumentError.new(validation_results.messages(full: true).values.join("\n")) unless validation_results.success?
  end

  def validation_schema
    Dry::Validation.Schema do
      required(:state, :array).filled
      required(:x, :integer).value(gt?: 0)
      required(:y1, :integer).value(gt?: 0)
      required(:y2, :integer).value(gt?: 0)
      required(:'x-m').value(lteq?: 0)
      required(:'y1-n').value(lteq?: 0)
      required(:'y2-n').value(lteq?: 0)
      required(:colour, :string).value(format?: /^[A-Z]$/)
    end
  end
end
