# frozen_string_literal: true

require "halcyoninae/arguments/required"
require "halcyoninae/options/long"

module Halcyoninae
  class Command
    def initialize(arguments:, options:, position:)
      @__arguments = arguments.drop(position)
      @__options = options

      parse_arguments && parse_options
    end

    def run
      runner.new(operations).run
    end

    private

    def set_instance_variable(name, value)
      instance_variable_set(name, value)
    end

    def define_instance_method(name, instance_variable_name)
      define_singleton_method(name) do
        instance_variable_get(instance_variable_name)
      end
    end

    def parse_arguments
      Array(arguments).each_with_index do |argument, index|
        value = @__arguments[index]

        argument.validate(value)

        instance_variable_name = "@__#{argument.name}"
        set_instance_variable(instance_variable_name, value)
        define_instance_method(argument.name, instance_variable_name)
      end
    end

    def parse_options
      set_instance_variable("@__params", parsed_options)
      define_instance_method("params", "@__params")
    end

    def parsed_options
      Array(options).each_with_object({}) do |option, hash|
        hash.merge!(option.name => @__options["--#{option.name}"])
      end
    end
  end
end
