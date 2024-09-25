defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {number, number}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: number
  def real({real, _}) do
    real
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: number
  def imaginary({_, imaginary}) do
    imaginary
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul(a, {b_real, b_img}) when is_number(a), do: {a * b_real, a * b_img}
  def mul({a_real, a_img}, b) when is_number(b), do: {a_real * b, a_img * b}

  def mul({a_real, a_img}, {b_real, b_img}) do
    {a_real * b_real - a_img * b_img, a_real * b_img + b_real * a_img}
  end

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add(a, b) when is_number(a), do: {a, 0} |> add(b)
  def add({a_real, a_img}, b) when is_number(b), do: {a_real, a_img} |> add({b, 0})

  def add({a_real, a_img}, {b_real, b_img}) do
    {a_real + b_real, a_img + b_img}
  end

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub(a, b) when is_number(a), do: {a, 0} |> sub(b)
  def sub({a_real, a_img}, b) when is_number(b), do: {a_real, a_img} |> sub({b, 0})

  def sub({a_real, a_img}, {b_real, b_img}) do
    {a_real - b_real, a_img - b_img}
  end

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div(a, b) when is_number(a), do: {a, 0} |> ComplexNumbers.div(b)
  def div({a_real, a_img}, b) when is_number(b), do: {a_real, a_img} |> ComplexNumbers.div({b, 0})

  def div({a_real, a_img}, {b_real, b_img}) do
    {(a_real * b_real + a_img * b_img) / (b_real ** 2 + b_img ** 2),
     (a_img * b_real - a_real * b_img) / (b_real ** 2 + b_img ** 2)}
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: number
  def abs({real, img}) do
    (real ** 2 + img ** 2) ** 0.5
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({real, img}) do
    {real, -img}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({real, img}) do
    {:math.exp(real) * :math.cos(img), :math.exp(real) * :math.sin(img)}
  end
end
