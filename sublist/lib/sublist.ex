defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist

  def compare(a, b) do
    cond do
      sublist?(a, b) -> :superlist
      sublist?(b, a) -> :sublist
      true -> :unequal
    end
  end

  defp sublist?([], _), do: false

  defp sublist?(l1 = [_ | t], l2) do
    List.starts_with?(l1, l2) or sublist?(t, l2)
  end
end
