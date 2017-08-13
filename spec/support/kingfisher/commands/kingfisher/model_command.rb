require_relative "../../runners/controller_runner"
require_relative "../../ops/copy_template_op"

module Kingfisher
  class ModelCommand < Halcyoninae::Command
    def description
      "Generate a Model"
    end

    def arguments
      [
        Halcyoninae::RequiredArgument.new("MODEL", desc: "controller name")
      ]
    end

    def options
      {}
    end

    def runner
      ControllerRunner
    end

    def template_root
      File.expand_path "../templates", __dir__
    end

    def operations
      [
        CopyTemplateOp.new(
          "#{template_root}/web/controllers/controller.erb",
          "web/controllers/#{controller_name.downcase}_controller.rb",
          context: { resource_class: controller_name }
        )
      ]
    end
  end
end
