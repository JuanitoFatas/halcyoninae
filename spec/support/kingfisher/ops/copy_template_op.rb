require "erubi"

class CopyTemplateOp
  def initialize(template, destination, context: {})
    @template = template
    @destination = destination
    bind_variables(context)
  end

  def perform(runner)
    runner.cp_a new_controller_file, destination
  end

  private
  attr_reader :template, :destination, :context

  def view_context
    @_view_context ||= binding
  end

  def bind_variables(context)
    context.each do |name, value|
      view_context.local_variable_set(name, value)
    end
  end

  def new_controller_file
    @_new_controller_file ||= begin
      tempfile = Tempfile.new
      tempfile.write view_context.eval(erb_src)
      tempfile.close
      tempfile.path
    end
  end

  def erb_src
    Erubi::Engine.new(template_content).src
  end

  def template_content
    File.read(template)
  end
end
