defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    # Enum.find(1..radicand, &(&1 * &1 >= radicand))
    babylonian(radicand, radicand)
  end

  defp babylonian(x, acc) when round(acc * acc) == x, do: round(acc)
  defp babylonian(x, acc), do: babylonian(x, (acc + x / acc) / 2)
end
