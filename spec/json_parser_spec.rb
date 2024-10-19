require_relative "../src/json_parser"

RSpec.describe JSONParser do
  describe "#parse" do
    context "with valid JSON" do
      it "returns a message and exit code 0 to stdout" do
        valid_json = "{}"
        parser = JSONParser.new()
        output = <<~OUTPUT
          valid json
          Process finished with exit code 0
        OUTPUT
        expect { parser.parse(valid_json) }.to output(output).to_stdout
      end
    end

    context "with invalid JSON" do
      it "returns a message and exit code 1 to stdout" do
        invalid_json = ""
        parser = JSONParser.new()
        output = <<~OUTPUT
          invalid json
          Process finished with exit code 1
        OUTPUT
        expect { parser.parse(invalid_json) }.to output(output).to_stdout
      end
    end
  end
end
