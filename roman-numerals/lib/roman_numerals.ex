defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) when number < 10, do: convert(number, "I", "V", "X")

  def numeral(number) when number < 100,
    do: convert(div(number, 10), "X", "L", "C") <> numeral(rem(number, 10))

  def numeral(number) when number < 1000,
    do: convert(div(number, 100), "C", "D", "M") <> numeral(rem(number, 100))

  def numeral(number) when number < 4000,
    do: convert(div(number, 1000), "M", "C", "") <> numeral(rem(number, 1000))

  defp convert(number, numeral, middle, next) do
    cond do
      number <= 3 -> String.duplicate(numeral, number)
      number == 4 -> numeral <> middle
      number <= 8 -> middle <> String.duplicate(numeral, number - 5)
      number == 9 -> numeral <> next
    end
  end
end
