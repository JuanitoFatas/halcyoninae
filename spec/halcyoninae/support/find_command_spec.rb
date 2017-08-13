RSpec.describe Halcyoninae::FindCommand do
  describe "find invoked command by passed in arguments from registries" do
    class VersionCommand
    end

    class ControllerCommand
    end

    def registries
      {
        "version" => VersionCommand,
        "generate"=> {
          "controller" => ControllerCommand
        }
      }
    end

    it "bin/rails" do
      arguments = []
      require "pry"; binding.pry;

      result = Halcyoninae::FindCommand.new(registries, arguments).run

      expect(result).to be_a Halcyoninae::NoCommand
    end

    it "bin/rails generate" do
      arguments = ["generate"]

      result = Halcyoninae::FindCommand.new(registries, arguments).run

      expect(result).to eq "generate"
    end

    it "bin/rails generate controller" do
      arguments = ["generate", "controller"]

      result = Halcyoninae::FindCommand.new(registries, arguments).run

      expect(result).to eq "generate controller"
    end
  end
end
