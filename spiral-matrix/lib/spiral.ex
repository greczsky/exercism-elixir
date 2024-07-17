defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []

  def matrix(dimension), do: do_matrix(dimension, dimension, 1)

  defp do_matrix(_, 0, _), do: [[]]

  defp do_matrix(rows, cols, min) do
    top_row = Enum.to_list(min..(min + cols - 1))
    other_rows = do_matrix(cols, rows - 1, min + cols) |> rotate_right
    IO.inspect([top_row | other_rows], charlists: :as_lists)
    [top_row | other_rows]
  end

  defp rotate_right(rows), do: rows |> Enum.reverse() |> transpose

  defp transpose(rows), do: rows |> List.zip() |> Enum.map(&Tuple.to_list/1)
end
