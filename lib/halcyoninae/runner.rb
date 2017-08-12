module Halcyoninae
  class Runner
    def initialize(operations)
      @operations = operations
    end

    def run
      operations.each do |operation|
        operation.perform(self)
      end
    end

    private
    attr_reader :operations
  end
end
