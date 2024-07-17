defmodule PopCount do
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(number) when number == 0, do: 0
  def egg_count(number) do
    if Bitwise.band(number, 1) == 1 do
      1 + egg_count(Bitwise.bsr(number, 1))
    else
      egg_count(Bitwise.bsr(number, 1))
    end 
  end
end
