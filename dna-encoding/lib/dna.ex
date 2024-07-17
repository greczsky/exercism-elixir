defmodule DNA do
  def encode_nucleotide(?\s), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000

  def decode_nucleotide(0b0000), do: ?\s
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  defp do_encode([], acc), do: acc

  defp do_encode([nucleotide | dna_rest], acc) do
    encoded = encode_nucleotide(nucleotide)
    do_encode(dna_rest, <<acc::bitstring, encoded::4>>)
  end

  def decode(dna) do
    do_decode(dna, [])
    |> do_revert([])
  end

  defp do_decode(<<>>, acc), do: acc

  defp do_decode(<<nucleotide::4, rest::bitstring>>, acc) do
    decoded = decode_nucleotide(nucleotide)
    do_decode(rest, [decoded | acc])
  end

  defp do_revert([], acc), do: acc
  defp do_revert([head | tail], acc), do: do_revert(tail, [head | acc])
end
