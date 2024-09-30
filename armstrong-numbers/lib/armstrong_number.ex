defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = number |> Integer.digits()
    digits_length = length(digits)

    digits
    |> Enum.map(&(&1 ** digits_length))
    |> Enum.sum()
    |> Kernel.==(number)
  end
end
