class MakeDirOp
  def initialize(name)
    @name = name
  end

  def perform(runner)
    runner.mkdir_p name
  end

  private
  attr_reader :name
end
