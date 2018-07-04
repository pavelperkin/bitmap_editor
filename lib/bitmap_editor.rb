require_relative 'instruction_parser'

class BitmapEditor

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)
    bitmap = []
    File.open(file).each do |line|
      cmd, *attrs = InstructionParser.new(line: line.chomp).parse
      bitmap = cmd.new(state: bitmap, args: attrs).run
    end
    bitmap
  rescue ArgumentError => e
    puts e.message
    exit 1
  end
end
