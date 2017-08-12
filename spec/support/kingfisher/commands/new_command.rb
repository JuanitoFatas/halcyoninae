require_relative "../runners/dry_run_new_runner"
require_relative "../runners/destroy_new_runner"
require_relative "../runners/new_runner"
require_relative "../ops/make_dir_op"
require_relative "../ops/copy_file_op"

class NewCommand < Halcyoninae::Command
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
      Halcyoninae::Arguments::Required.new("project_name", desc: "app folder name")
    ]
  end

  def options
    [
      Halcyoninae::Options::Long.new("dry-run", desc: "print what to do but don't do it"),
      Halcyoninae::Options::Long.new("destroy", desc: "undo")
    ]
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
      CopyFileOp.new("templates/web/views/application_view.rb", "#{web}/views/application_view.rb"),
      CopyFileOp.new("templates/web/router.rb", "#{web}/router.rb")
    ]
  end
end
