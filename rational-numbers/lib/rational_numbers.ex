import Bitwise

defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}) do
    reduce({a1 * b2 + a2 * b1, b1 * b2})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) do
    reduce({a1 * b2 - a2 * b1, b1 * b2})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    reduce({a1 * a2, b1 * b2})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}) do
    cond do
      a2 != 0 -> reduce({a1 * b2, a2 * b1})
      true -> 0
    end
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a, b}) do
    reduce({bxor(a + (a >>> 31), a >>> 31), bxor(b + (b >>> 31), b >>> 31)})
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) when n < 0,
    do: reduce({Integer.pow(b, n * -1), Integer.pow(a, n * -1)})

  def pow_rational({a, b}, n) when n >= 0, do: reduce({Integer.pow(a, n), Integer.pow(b, n)})

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}) do
    x ** (a / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({a, b}) do
    lowest = gcd(a, b)
    {a, b} = {Integer.floor_div(a, lowest), Integer.floor_div(b, lowest)}

    cond do
      b < 0 -> {a * -1, b * -1}
      true -> {a, b}
    end
  end

  def gcd(a, b) when b == 0, do: a

  def gcd(a, b) do
    gcd(b, rem(a, b))
  end
end
