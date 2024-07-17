defmodule ResistorColorTrio do
  @color_map %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @metric_table %{
    0 => :ohms,
    1 => :kiloohms,
    2 => :megaohms,
    3 => :gigaohms
  }

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([first | [second | [third | _tail]]]) do
    number =
      (@color_map[first] * 10 + @color_map[second]) *
        10 ** @color_map[third]

    normalize(number, 0)
  end

  defp normalize(number, count) when number < 1000, do: {number, @metric_table[count]}

  defp normalize(number, count) do
    normalize(div(number, 1000), count + 1)
  end
end
