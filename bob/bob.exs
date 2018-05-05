defmodule Bob do
  def hey(input) do
    cond do
      is_silence?(input) ->
        "Fine. Be that way!"
      is_shouted_question?(input) -> 
        "Calm down, I know what I'm doing!"
      is_shouting?(input) -> 
        "Whoa, chill out!"
      is_question?(input) -> 
        "Sure."
      true -> 
        "Whatever."
    end
  end

  defp is_silence?(input), do: String.match?(input, ~r/^\s{0,}$/)

  defp is_shouting?(input) do
    String.match?(input, ~r/[\p{L}]/u) && input == String.upcase(input)
  end

  defp is_question?(input) do
    String.ends_with?(input, "?")
  end
  
  defp is_shouted_question?(input) do
    is_question?(input) and is_shouting?(input)
  end
end
