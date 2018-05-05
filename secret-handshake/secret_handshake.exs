defmodule SecretHandshake do

  @actions ["wink", "double blink", "close your eyes", "jump" ]
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code
      |> Integer.digits(2)
      |> Enum.reverse
      |> Enum.with_index
      |> Enum.reduce([], fn(i, acc) -> 
        {value, index} = i
        cond do
          index == 4 -> Enum.reverse(acc)
          value == 1 -> acc ++ [Enum.at(@actions, index)]
          true -> acc
        end
        end)
      |> Enum.filter(fn i -> !is_nil(i) end)
  end

  def fucker do
    Enum.at(@actions, 0)
  end
end
