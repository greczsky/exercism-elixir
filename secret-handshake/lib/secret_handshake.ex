defmodule SecretHandshake do
  import Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    handshake =
      code
      |> Integer.digits(2)
      |> Enum.reverse()
      |> do_handshake

    case code &&& 0x10 do
      0 -> handshake
      _ -> Enum.reverse(handshake)
    end
  end

  defp do_handshake(
         code,
         handshake \\ ["wink", "double blink", "close your eyes", "jump"]
       )

  defp do_handshake(_, []), do: []

  defp do_handshake([h | t], [hh | ht]) do
    case(h) do
      0 -> do_handshake(t, ht)
      1 -> [hh | do_handshake(t, ht)]
    end
  end

  defp do_handshake([], _), do: []
end
