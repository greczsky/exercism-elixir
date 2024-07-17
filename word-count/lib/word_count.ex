defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase(:ascii)
    |> String.split(~r/[:!?,.\t\n _&@$%^]/, trim: true)
    |> Enum.map(&String.trim(&1, "'"))
    |> Enum.reduce(%{}, fn word, acc -> Map.update(acc, word, 1, &(&1 + 1)) end)
  end
end
