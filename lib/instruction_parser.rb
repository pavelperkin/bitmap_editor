require 'validator'
require 'command'

class InstructionParser
  def initialize(line: , dictionary: './lib/instructions.yml')
    @line = line.to_s
    @dictionary = dictionary.to_s
    validate_line!
    validate_dictionary!
  end

  def parse()
    Command.new()
  end

  private

  def validate_line!()
    raise ArgumentError unless Validator.new(obj: @line, rules: { empty?: false }).valid?
  end

  def validate_dictionary!()
    raise ArgumentError unless Validator.new(obj: @dictionary).valid_file?
  end
end
