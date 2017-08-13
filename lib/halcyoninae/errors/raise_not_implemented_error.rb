class RaiseNotImplementedError
  def initialize(method_name, klass_name)
    @method_name = method_name
    @klass_name = klass_name
  end

  def run
    raise NotImplementedError, "Please implement ##{method_name} in your #{klass_name} class."
  end

  private
  attr_reader :method_name, :klass_name
end
