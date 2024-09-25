defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep([], _), do: []

  def keep([item | list], fun) do
    case fun.(item) do
      true ->
        [item | keep(list, fun)]

      false ->
        keep(list, fun)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard([], _), do: []

  def discard([item | list], fun) do
    case(fun.(item)) do
      true ->
        discard(list, fun)

      false ->
        [item | discard(list, fun)]
    end
  end
end
