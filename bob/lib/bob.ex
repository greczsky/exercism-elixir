defmodule Bob do
  defp question?(input), do: String.ends_with?(input, "?")
  defp yelling?(input), do: input =~ ~r/^[^a-z]+$/ and input =~ ~r/[[:upper:]]/
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input = String.trim(input)

    cond do
      input == "" -> "Fine. Be that way!"
      question?(input) && yelling?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      yelling?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end
end
