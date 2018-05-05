defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
      |> String.replace(~r/[^a-z-_\s\d\p{L}]/ui, "")
      |> String.replace("_", " ")
      |> String.split(" ")
      |> Enum.filter(fn word -> word != "" end)
      |> Enum.map(fn word -> String.downcase word end )
      |> Enum.reduce(%{}, &gen_count_map/2 )
  end

  defp gen_count_map(word, acc) do
      cond do
        Map.has_key?(acc, word) -> 
          prev_word_count = Map.fetch!(acc, word)
          %{acc | word => prev_word_count + 1}
        true -> 
          Map.put(acc, word, 1)
      end
  end
end
