require_relative "../src/tokenizer"

RSpec.describe Tokenizer do
  # Define a set of test cases with different inputs and expected outputs
  test_cases = [
    { json_string: "{}", tokens: [{ type: "LBRACE", value: "{" }, { type: "RBRACE", value: "}" }] },
    { json_string: "[]", tokens: [{ type: "LBRACKET", value: "[" }, { type: "RBRACKET", value: "]" }] },
    { json_string: '{"key": "value"}', tokens: [
      { type: "LBRACE", value: "{" },
      { type: "STRING", value: "key" },
      { type: "COLON", value: ":" },
      { type: "STRING", value: "value" },
      { type: "RBRACE", value: "}" },
    ] },
  ]

  # Loop over each test case
  test_cases.each do |test_case|
    context "when the input is '#{test_case[:json_string]}'" do
      it "it should return the expected list of tokens" do
        tokenizer = Tokenizer.new(test_case[:json_string])
        tokenizer.tokenize
        expect(tokenizer.get_tokens).to eq(test_case[:tokens])
      end
    end
  end
end
