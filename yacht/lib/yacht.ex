defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(category, dice), do: dice |> Enum.sort() |> do_score(category)

  defp do_score(dices, :ones), do: simple_score(dices, 1)
  defp do_score(dices, :twos), do: simple_score(dices, 2)
  defp do_score(dices, :threes), do: simple_score(dices, 3)
  defp do_score(dices, :fours), do: simple_score(dices, 4)
  defp do_score(dices, :fives), do: simple_score(dices, 5)
  defp do_score(dices, :sixes), do: simple_score(dices, 6)
  defp do_score([d, d, d, d, d], :full_house), do: 0
  defp do_score([a, a, b, b, b], :full_house), do: a * 2 + b * 3
  defp do_score([a, a, a, b, b], :full_house), do: a * 3 + b * 2
  defp do_score([1, 2, 3, 4, 5], :little_straight), do: 30
  defp do_score([2, 3, 4, 5, 6], :big_straight), do: 30
  defp do_score([d, d, d, d, _], :four_of_a_kind), do: d * 4
  defp do_score([_, d, d, d, d], :four_of_a_kind), do: d * 4
  defp do_score(dices, :choice), do: Enum.sum(dices)
  defp do_score([d, d, d, d, d], :yacht), do: 50
  defp do_score(_, _), do: 0

  defp simple_score(dices, num), do: dices |> Enum.count(&(&1 == num)) |> Kernel.*(num)
end
