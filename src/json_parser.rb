class JSONParser
  def parse(string)
    @string = string
    Program
  end

  def Program
    {
      type: "Program",
      body: [],
    }
  end

  def LeftParen
    {
      type: "LeftParen",
      value: @string,
    }
  end

  def RightParen
    {
      type: "RightParen",
      value: @string,
    }
  end
end
