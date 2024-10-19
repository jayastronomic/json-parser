class Tokenizer
  TOKEN_TYPES = [
    ["LBRACE", /\{/],
    ["RBRACE", /\}/],
    ["LBRACKET", /\[/],
    ["RBRACKET", /\]/],
    ["COLON", /:/],
    ["COMMA", /,/],
    ["NUMBER", /-?\d+(\.\d+)?([eE][+-]?\d+)?/],
    ["TRUE", /true/],
    ["FALSE", /false/],
    ["NULL", /null/],
    ["QUOTE", /\"/],
    ["WHITESPACE", /\s+/],
  ]

  def initialize(string)
    @string = string
    @offset = 0
    @cursor = 0
    @peeker = 0
    @tokens = []
  end

  def create_token(type, value)
    { type: type, value: value }
  end

  def has_more_tokens?
    @cursor < @string.length
  end

  def get_tokens
    @tokens
  end

  def analyze_characters
    match_found = false
    while !match_found
      substr = @string.slice(@offset..@cursor)
      TOKEN_TYPES.each do |type, pattern|
        if pattern.match(substr)
          if type != "WHITESPACE"
            if type === "NUMBER"
              @peeker = @cursor
              while (Tokenizer::TOKEN_TYPES[7][1].match(@string[@peeker += 1]))
                substr << @string[@peeker]
                @cursor += 1
              end
            end
            if type === "QUOTE"
              string = ""
              while (!Tokenizer::TOKEN_TYPES[10][1].match(@string[@cursor += 1]))
                string << @string[@cursor]
              end
              substr = string
            end
            puts substr if @cursor == 8
            @tokens << create_token(type, substr)
          end
          match_found = true
          @offset = @cursor += 1
          break
        end
      end
      @cursor += 1 if !match_found
    end
  end

  def tokenize
    while has_more_tokens?
      analyze_characters
    end
  end
end

json_string = '{
  "id": 99999
}'

tokenizer = Tokenizer.new(json_string)
tokenizer.tokenize
puts tokenizer.get_tokens
