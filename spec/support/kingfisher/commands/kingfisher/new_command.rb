require_relative "../../runners/dry_run_new_runner"
require_relative "../../runners/destroy_new_runner"
require_relative "../../runners/new_runner"
require_relative "../../ops/make_dir_op"
require_relative "../../ops/copy_file_op"

module Kingfisher
  class NewCommand < Halcyoninae::Command
    def description
      "Generate a new Kingfisher project"
    end

    def runner
      case
      when params["dry-run"] then DryRunNewRunner
      when params["destroy"] then DestroyNewRunner
      else
        NewRunner
      end
    end

    def arguments
      [
        Halcyoninae::RequiredArgument.new("project_name", desc: "Usage: kingfisher new")
      ]
    end

    def options
      [
        Halcyoninae::Options::Long.new("dry-run", desc: "print what to do but don't do it"),
        Halcyoninae::Options::Long.new("destroy", desc: "undo")
      ]
    end

    def template_root
      File.expand_path "../templates", __dir__
    end

    def operations
      web = File.join project_name, "web"

      [
        MakeDirOp.new(project_name),
        MakeDirOp.new("#{web}"),
        MakeDirOp.new("#{web}/controllers"),
        MakeDirOp.new("#{web}/forms"),
        MakeDirOp.new("#{web}/public"),
        MakeDirOp.new("#{web}/templates"),
        MakeDirOp.new("#{web}/views"),
        CopyFileOp.new("#{template_root}/web/views/application_view.rb", "#{web}/views/application_view.rb"),
        CopyFileOp.new("#{template_root}/web/router.rb", "#{web}/router.rb")
      ]
    end
  end
end
