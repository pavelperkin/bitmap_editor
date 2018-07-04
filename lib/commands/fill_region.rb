require_relative '../commands'
require 'dry-validation'

class Commands::FillRegion
  def initialize(state:, args: nil)
    @state = state.to_a
    @x = args[0].to_i
    @y = args[1].to_i
    @colour = args[2].to_s
    validate!
  end

  def run()
    @state[@x-1][@y-1] = 0
    index = 1

    while true do
      flag = false
      @state.each_with_index do |row, j|
        row.each_with_index do |el, k|
          if el == index - 1
            mark_neighbors(xt: j, yt: k, colour: @colour, n: index)
            flag = true
          end
        end
      end
      if flag
        index += 1
      else
        break
      end
    end

    paint_bitmap
  end

  private

  def paint_bitmap
    @state.map! do |row|
      row.map! do |el|
        if el.is_a? Integer
          el = @colour
        else
          el = el
        end
      end
    end
  end

  def mark_neighbors(xt: , yt: , colour: , n:)
    @state[xt][yt+1] = n if yt < @state.size and (@state[xt][yt+1]=='O' or @state[xt][yt+1]==colour)
    @state[xt][yt-1] = n if yt > 0 and (@state[xt][yt-1]=='O' or @state[xt][yt-1]==colour)
    @state[xt+1].to_a[yt] = n if xt < @state.map(&:size).first.to_i and (@state[xt+1].to_a[yt]=='O' or @state[xt+1].to_a[yt]==colour)
    @state[xt-1][yt] = n if xt > 0 and (@state[xt-1].to_a[yt]=='O' or @state[xt-1][yt]==colour)
  end

  def validate!
    n = @state.size
    m = @state.map(&:size).first.to_i
    validation_results = validation_schema.call( { state: @state,
                                                   x: @x,
                                                   y: @y,
                                                   colour: @colour,
                                                   'x-m': @x-m,
                                                   'y-n': @y-n } )
    raise ArgumentError.new(validation_results.messages(full: true).values.join("\n")) unless validation_results.success?
  end

  def validation_schema
    Dry::Validation.Schema do
      required(:state, :array).filled
      required(:x, :integer).value(gt?: 0)
      required(:y, :integer).value(gt?: 0)
      required(:'x-m').value(lteq?: 0)
      required(:'y-n').value(lteq?: 0)
      required(:colour, :string).value(format?: /^[A-Z]$/)
    end
  end
end
