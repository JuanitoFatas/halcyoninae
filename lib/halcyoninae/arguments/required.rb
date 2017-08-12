# frozen_string_literal: true

require "halcyoninae/io"

module Halcyoninae
  module Arguments
    class Required
      attr_reader :name, :desc

      def initialize(name, desc:)
        @name = name
        @desc = desc
      end

      def validate(value)
        if !value
          IO.new.puts("#{usage} <#{name}>")
          exit(129)
        end
      end

      private

      def usage
        "Usage: kingfisher new"
      end
    end
  end
end
