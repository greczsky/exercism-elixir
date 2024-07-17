defmodule VariableLengthQuantity do
  import Bitwise

  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode(integers) do
    Enum.reduce(integers, <<>>, &encode_integer/2)
  end

  defp encode_integer(0, acc), do: acc <> <<0>>
  defp encode_integer(integer, acc), do: acc <> encode_integer(integer, 0, <<>>)

  defp encode_integer(0, _, acc), do: acc

  defp encode_integer(integer, lsb, acc),
    do: encode_integer(integer >>> 7, 1, <<lsb::1, integer::7, acc::binary>>)

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes), do: do_decode(bytes, 0, [])

  defp do_decode(<<>>, 0, []), do: {:error, "incomplete sequence"}
  defp do_decode(<<>>, 0, acc), do: {:ok, Enum.reverse(acc)}

  defp do_decode(<<0::1, bits::7, rest::binary>>, i, acc),
    do: do_decode(rest, 0, [(i <<< 7) + bits | acc])

  defp do_decode(<<1::1, bits::7, rest::binary>>, i, acc),
    do: do_decode(rest, (i <<< 7) + bits, acc)

  defp do_decode(<<_::binary>>, _, _), do: {:error, "incomplete sequence"}
end
