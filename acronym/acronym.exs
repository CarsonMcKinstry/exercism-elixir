defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
      |> String.replace(~r/\W/, " ")
      |> String.split
      |> Enum.map(&split_on_capitals/1)
      |> Enum.map(&get_char/1)
      |> Enum.join("")
  end

  def get_char([char, _]), do: String.upcase(char)
  def get_char([word]) do 
    cond do
      is_list(word) -> List.first(word) |> String.upcase
      true -> String.first(word) |> String.upcase 
    end
  end


  def split_on_capitals word do
    split_word = Regex.split(~r/[A-Z]/, word, include_captures: true, trim: true)
    cond do
      length(split_word) > 2 -> 
        Enum.chunk(split_word, 2)
      true -> split_word
    end
  end
end
