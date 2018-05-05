defmodule TwelveDays do
  @number_words [
    "first","second","third",
    "fourth","fifth","sixth",
    "seventh","eighth","ninth",
    "tenth","eleventh","twelfth"
  ]
  @gifts [
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ]

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do 
    gifts = @gifts
      |> Enum.slice(0, number)
      |> format_gifts
    
    day = Enum.at(@number_words, number - 1)
    "On the #{day} day of Christmas my true love gave to me, #{gifts}."
  end

  defp format_gifts([head | tail]) do
    if length(tail) == 0 do
      head
    else
      tail = tail
        |> Enum.reverse
        |> Enum.join(", ")
      
      "#{tail}, and #{head}"
    end
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    final = for v <- starting_verse..ending_verse, into: [] do
      verse(v)
    end
    final
      |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing, do: verses(1,12)
end
