defmodule Username do
  @special_char %{
    ?ä => ~c"ae",
    ?ö => ~c"oe",
    ?ü => ~c"ue",
    ?ß => ~c"ss"
  }

  def sanitize([]), do: ~c""

  def sanitize([letter | tail]) do
    case letter do
      letter when (letter >= ?a and letter <= ?z) or letter == ?_ ->
        [letter | sanitize(tail)]

      letter when letter in ~c"äöüß" ->
        @special_char[letter] ++ sanitize(tail)

      _ ->
        sanitize(tail)
    end
  end
end
