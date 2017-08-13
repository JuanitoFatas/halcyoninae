# frozen_string_literal: true

module Halcyoninae
  class Argument
    attr_reader :name, :desc

    def initialize(name, desc:)
      @name = name
      @desc = desc
    end
  end
end
