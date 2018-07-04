require 'yaml'
require_relative 'commands'
Dir["./lib/commands/*.rb"].each { |file| require file }

class InstructionParser
  def initialize(line: , dictionary: './lib/instructions.yml')
    @line = line.to_s
    @dictionary = dictionary.to_s
    validate!
    @instructions = YAML.load_file(@dictionary)
  end

  def parse()
    cmd_name, *attrs = @line.split
    attrs.unshift(Commands.const_get(@instructions[cmd_name]))
  end

  private

  def validate!
    validation_results = validation_schema.call( { line: @line, dictionary: @dictionary, file_exist: File.exist?(@dictionary) } )
    raise ArgumentError.new(validation_results.messages(full: true).values.join("\n")) unless validation_results.success?
  end

  def validation_schema
    Dry::Validation.Schema do
      required(:line, :str).filled
      required(:dictionary, :str).filled
      required(:file_exist, :bool).value(:true?)
    end
  end
end
