class CopyFileOp
  def initialize(from, to)
    @from = from
    @to = to
  end

  def perform(runner)
    runner.cp_a from, to
  end

  private
  attr_reader :from, :to
end
