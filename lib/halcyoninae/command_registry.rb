# frozen_string_literal: true

module Halcyoninae
  class CommandRegistry
    def initialize(registries, arguments)
      @registries = registries
      @arguments = arguments
    end

    def find_command
      command_name
    end

    private
    attr_reader :registries, :arguments

    def command_name
      candidates.reverse_each.find do |candidate|
        lookup_from_registries(candidate)
      end
    end

    def candidates
      arguments.map.with_index do |e, index|
        if index == 0
          arguments.first
        else
          arguments[0..index].join(" ")
        end
      end
    end

    def lookup_from_registries(name)
      registries[name]
    end
  end
end
