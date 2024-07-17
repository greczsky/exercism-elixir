defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    !(number =~ ~r/[^\d ]/) &&
      String.trim(number) |> String.length() > 1 &&
      number
      |> String.replace(~r/\D/, "")
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.reverse()
      |> Enum.chunk_every(2, 2, Stream.cycle([0]))
      |> Enum.reduce(0, fn [x, y], acc ->
        acc + x + if(y * 2 > 9, do: y * 2 - 9, else: y * 2)
      end)
      |> then(&(rem(&1, 10) == 0))
  end
end
