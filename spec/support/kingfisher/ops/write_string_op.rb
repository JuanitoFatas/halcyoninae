class WriteStringOp
  def initialize(string)
    @string = string
  end

  def perform(runner)
    runner.write_string string
  end

  private
  attr_reader :string
end
