defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers \\ {}, key)
  def search({}, _key), do: :not_found

  def search(numbers, key) do
    size = tuple_size(numbers)
    bin_search(numbers, key, 0, size - 1)
  end

  defp bin_search(numbers, key, low, high) do
    mid = div(low + high, 2)
    number = elem(numbers, mid)

    cond do
      number == key -> {:ok, mid}
      low > high -> :not_found
      number < key -> bin_search(numbers, key, mid + 1, high)
      number > key -> bin_search(numbers, key, low, mid - 1)
    end
  end
end
