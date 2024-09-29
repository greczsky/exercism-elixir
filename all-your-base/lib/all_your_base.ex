defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, input_base, _) when input_base < 2, do: {:error, "input base must be >= 2"}
  def convert(_, _, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  def convert([], _, _), do: {:ok, [0]}
  def convert([0 | rest], input_base, output_base), do: convert(rest, input_base, output_base)

  def convert(digits, input_base, output_base) do
    if Enum.any?(digits, &(&1 < 0 || &1 >= input_base)) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      decimal = Enum.reduce(digits, 0, fn d, acc -> acc * input_base + d end)

      {:ok, decimal_to_base(decimal, output_base, [])}
    end
  end

  def decimal_to_base(0, _, acc), do: acc

  def decimal_to_base(decimal, output_base, acc) do
    decimal_to_base(div(decimal, output_base), output_base, [rem(decimal, output_base) | acc])
  end
end
