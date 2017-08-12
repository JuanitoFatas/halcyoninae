require_relative "../runners/version_runner"
require_relative "../ops/write_string_op"

class VersionCommand < Halcyoninae::Command
  def runner
    VersionRunner
  end

  def arguments
  end

  def options
  end

  def operations
    [
      WriteStringOp.new("0.0.1")
    ]
  end
end
