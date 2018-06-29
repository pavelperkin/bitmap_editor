require 'yaml'
require_relative 'validator'
require_relative 'commands'
Dir["./lib/commands/*.rb"].each { |file| require file }

class InstructionParser
  def initialize(line: , dictionary: './lib/instructions.yml')
    @line = line.to_s
    @dictionary = dictionary.to_s
    validate_line!
    validate_dictionary!
    @instructions = YAML.load_file(@dictionary)
  end

  def parse()
    cmd_name, *attrs = @line.split
    attrs.unshift(Commands.const_get(@instructions[cmd_name]))
  end

  private

  def validate_line!()
    raise ArgumentError unless Validator.new(obj: @line, rules: { empty?: false }).valid?
  end

  def validate_dictionary!()
    raise ArgumentError unless Validator.new(obj: @dictionary).valid_file?
  end
end
