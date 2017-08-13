# frozen_string_literal: true

require_relative "argument"

module Halcyoninae
  class RequiredArgument < Argument
    def required?
      true
    end

    def validate(value)
      if value.nil?
        IO.new.puts("#{desc} <#{name}>")
        exit(129)
      end
    end
  end
end
