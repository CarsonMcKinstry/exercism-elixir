defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  defp days_to_seconds({:ok, days}), do: days * 24 * 60 * 60

  @planets %{
    :mercury => 87.969,
    :venus => 224.7,
    :earth => 365.2564,
    :mars => 687,
    :jupiter => 4332.59,
    :saturn => 10759,
    :uranus => 30688.5,
    :neptune => 60182
  }

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    seconds_p = Map.fetch(@planets, planet)
      |> days_to_seconds
    
    seconds / seconds_p
  end
end
