# frozen_string_literal: true

require_relative "argument"

module Halcyoninae
  class OptionalArgument < Argument
    def required?
      false
    end

    def validate(value)
      # no need to do anything
    end
  end
end
