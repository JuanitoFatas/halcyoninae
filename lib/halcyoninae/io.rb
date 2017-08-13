require "forwardable"

module Halcyoninae
  class IO
    extend Forwardable

    delegate %i(puts) => "@out"

    def initialize(out: $stdout)
      @out = out
    end
  end
end
