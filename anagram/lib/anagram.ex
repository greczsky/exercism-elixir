defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    letters = String.downcase(base) |> String.graphemes() |> Enum.sort()

    candidates
    |> Enum.filter(fn candidate -> String.downcase(candidate) != String.downcase(base) end)
    |> Enum.filter(fn candidate ->
      String.downcase(candidate) |> String.graphemes() |> Enum.sort() == letters
    end)
  end
end
