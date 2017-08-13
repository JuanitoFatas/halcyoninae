require_relative "../../runners/version_runner"
require_relative "../../ops/write_string_op"

module Kingfisher
  class VersionCommand < Halcyoninae::Command
    def description
      "Print Kingfisher version"
    end

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
end
