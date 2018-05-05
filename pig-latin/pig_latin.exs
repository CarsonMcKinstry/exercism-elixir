defmodule PigLatin do
  @vowels ~r/(^[aeiou]|^[xy][^aeiou])[a-z]{0,}/
  @consonants ~r/^[^aeiou].{0,}/
  @qu ~r/^(qu).{0,}/
  @squ ~r/^(squ).{0,}/
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do

    phrase
      |> String.split(" ")
      |> Enum.map(&translate_word/1)
      |> Enum.join(" ")

  end

  defp translate_consontant(word) do
    start = word
      |> String.split("", trim: true)
      |> Enum.flat_map_reduce([], fn (l, acc) -> 
          cond do
            String.match?(l, @consonants) -> {[l], acc}
            String.match?(l, @vowels) -> {:halt, acc}
          end
        end)
      |> (fn {start, _} -> Enum.join(start, "") end).()

    String.trim_leading(word, start) <> start <> "ay"
  end

  defp translate_word(word) do

    cond do
      String.match?(word, @vowels) -> word <> "ay"
      String.match?(word, @squ) ->
        rest = String.slice(word, 3..-1)
        qu = String.slice(word, 0..2)
        rest <> qu <> "ay"
      String.match?(word, @qu) ->
        rest = String.slice(word, 2..-1)
        qu = String.slice(word, 0..1)
        rest <> qu <> "ay"
      String.match?(word, @consonants) -> translate_consontant(word)

    end
  end

end
