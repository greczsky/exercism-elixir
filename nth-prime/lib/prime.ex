defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise(ArgumentError)
  def nth(count) when count < 3 and count > 0, do: count + 1

  def nth(count) do
    do_nth(count - 2, 6)
  end

  defp do_nth(1, value), do: value - 1

  defp do_nth(count, value) do
    sqrt = (value ** 0.5) |> trunc()

    case Enum.any?(2..sqrt, &(rem(value, &1) == 0)) do
      true ->
        do_nth(count, value + 1)

      false ->
        do_nth(count - 1, value + 1)
    end
  end
end
