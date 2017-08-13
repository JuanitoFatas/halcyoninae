RSpec.describe "Kingfisher CLI" do
  def kingfisher_exe
    File.expand_path("../support/kingfisher/bin/kingfisher", __dir__)
  end

  describe "kingfisher" do
    it "returns available commands" do
      output = <<~OUTPUT.rstrip
        Commands:
          kingfisher new [SUBCOMMAND] # Generate a new Kingfisher project
          kingfisher version # Print Kingfisher version
          kingfisher generate [SUBCOMMAND] #
      OUTPUT

      result = `#{kingfisher_exe}`.rstrip

      expect(result).to eq output
    end
  end

  describe "kingfisher version" do
    it "returns version string" do
      output = "0.0.1"

      result = `#{kingfisher_exe} version`.rstrip

      expect(result).to eq output
    end
  end

  describe "Command not exists" do
    it "display available commands" do
      result = `#{kingfisher_exe} thiscommandnotexists`

      expect(result).to include "Commands:"
    end
  end

  describe "kingfisher new" do
    it "without argument prints usage" do
      output = <<~OUTPUT
        Usage: kingfisher new <project_name>
      OUTPUT

      result = `#{kingfisher_exe} new`

      expect(result).to eq output
    end

    it "dry run tells us what would have executed" do
      output = <<~OUTPUT
        mkdir -p blog
        mkdir -p blog/web
        mkdir -p blog/web/controllers
        mkdir -p blog/web/forms
        mkdir -p blog/web/public
        mkdir -p blog/web/templates
        mkdir -p blog/web/views
        cp -a /Users/juanitofatas/dev/halcyoninae/spec/support/kingfisher/commands/templates/web/views/application_view.rb blog/web/views/application_view.rb
        cp -a /Users/juanitofatas/dev/halcyoninae/spec/support/kingfisher/commands/templates/web/router.rb blog/web/router.rb
      OUTPUT

      result = `#{kingfisher_exe} new blog --dry-run`

      expect(result).to eq output
    end

    it "blog & its reverse (--destroy option)" do
      Dir.chdir("spec/support/kingfisher") do
        begin
          `#{kingfisher_exe} new blog`
          expect(File.exist?("blog")).to be true
        ensure
          `#{kingfisher_exe} new blog --destroy`
          expect(File.exist?("blog")).to be false
        end
      end
    end
  end

  describe "kingfisher generate" do
    it "without argument display available subcommands" do
      output = <<~OUTPUT
        kingfisher generate controller # Generate a controller
        kingfisher generate model # Generate a model
      OUTPUT

      result = `#{kingfisher_exe} generate`

      expect(result).to eq output
    end
  end
end
