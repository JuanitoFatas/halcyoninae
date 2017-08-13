# frozen_string_literal: true

require "halcyoninae/errors/raise_not_implemented_error"

require "halcyoninae/arguments/required"
require "halcyoninae/options/long"

module Halcyoninae
  class Command
    def required_arguments
      return [] unless arguments

      arguments.select { |argument| argument.is_a? RequiredArgument }
    end

    def arguments
      RaiseNotImplementedError.new(__method__, self.class.name).run
    end

    def options
      RaiseNotImplementedError.new(__method__, self.class.name).run
    end

    def runner
      RaiseNotImplementedError.new(__method__, self.class.name).run
    end

    def operations
      RaiseNotImplementedError.new(__method__, self.class.name).run
    end

    def initialize(arguments: [], options: {}, position: 0)
      @__arguments = arguments.drop(position)
      @__options = options

      if !arguments.empty? || !options.empty?
        parse_arguments && parse_options
      end
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

        if argument.is_a? RequiredArgument
          argument.validate(value)
        end

        if argument.is_a? Argument
          instance_variable_name = "@__#{argument.name}"
          set_instance_variable(instance_variable_name, value)
          define_instance_method(argument.name, instance_variable_name)
        end
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
