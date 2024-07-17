defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number < 1,
    do: {:error, "Classification is only possible for natural numbers."}

  def classify(number) do
    sum = Enum.sum(factorize(number)) - number

    cond do
      sum < number -> {:ok, :deficient}
      sum > number -> {:ok, :abundant}
      true -> {:ok, :perfect}
    end
  end

  defp factorize(n) do
    Enum.filter(1..round(:math.sqrt(n)), &(rem(n, &1) == 0))
    |> Enum.flat_map(fn m ->
      if div(n, m) == m, do: [m], else: [m, div(n, m)]
    end)
  end
end
