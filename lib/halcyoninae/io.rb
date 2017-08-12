require "forwardable"

module Halcyoninae
  class IO
    extend Forwardable

    delegate %i(puts) => "@outs"

    def initialize(out: $stdout)
      @out = out
    end
  end
end
