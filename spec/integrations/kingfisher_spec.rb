RSpec.describe "Kingfisher CLI" do
  def kingfisher_exe
    File.expand_path("../support/kingfisher/bin/kingfisher", __dir__)
  end

  describe "kingfisher version" do
    it "returns version string" do
      result = `#{kingfisher_exe} version`

      expect(result).to eq "0.0.1\n"
    end
  end

  describe "Command not exists" do
    it "kingfisher thiscommandnotexists" do
      result = `#{kingfisher_exe} thiscommandnotexists`

      expect(result).to include "Command not found. Available commands:"
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
        cp -a templates/web/views/application_view.rb blog/web/views/application_view.rb
        cp -a templates/web/router.rb blog/web/router.rb
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
end
