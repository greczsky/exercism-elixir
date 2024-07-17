defmodule PaintByNumber do
  def palette_bit_size(0), do: 0
  def palette_bit_size(color_count) when color_count <= 2, do: 1

  def palette_bit_size(color_count) do
    1 + palette_bit_size(color_count / 2)
  end

  # defp size(color_count, size) do
  #   if pow(2, size) < color_count do
  #     size(color_count, size + 1)
  #   else
  #     size
  #   end
  # end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _), do: nil

  def get_first_pixel(picture, color_count) do
    size = palette_bit_size(color_count)
    <<pixel::size(size), _::bitstring>> = picture
    pixel
  end

  def drop_first_pixel(<<>>, _), do: <<>>

  def drop_first_pixel(picture, color_count) do
    size = palette_bit_size(color_count)
    <<_::size(size), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
