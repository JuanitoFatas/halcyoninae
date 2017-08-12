module Halcyoninae
  module Options
    class Long
      attr_reader :name, :desc

      def initialize(name, desc:)
        @name = name
        @desc = desc
      end
    end
  end
end
