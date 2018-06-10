class Validator
  attr_reader :errors

  def initialize(obj:, rules: {})
    @obj = obj
    @rules = rules
    @errors = []
  end

  def validate
    @rules.each do |rule, value|
      unless @obj.public_send(rule) == value
        @errors << "Method #{rule} should return #{value}"
      end
    end
    self
  end

  def valid?
    validate
    @errors.none?
  end
end
