defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> Stream.chunk_by(& &1)
    |> Enum.map_join(&encode_chunk/1)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.split(~r{\D}, include_captures: true)
    |> do_decode()
    |> Enum.join()
  end

  defp encode_chunk([char]), do: char
  defp encode_chunk(chunk), do: "#{length(chunk)}#{hd(chunk)}"

  defp do_decode([]), do: []

  defp do_decode([count | [char | tail]]) when is_integer(count) do
    [String.duplicate(char, count) | do_decode(tail)]
  end

  defp do_decode([char | tail]) do
    cond do
      String.match?(char, ~r{^\d+$}) -> do_decode([String.to_integer(char) | tail])
      true -> [char | do_decode(tail)]
    end
  end
end
