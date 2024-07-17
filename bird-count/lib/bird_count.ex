defmodule BirdCount do
  def today([]), do: nil
  def today([h | _]), do: h

  def increment_day_count([]), do: [1]
  def increment_day_count([h, t]), do: [h + 1 | t]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _]), do: true
  def has_day_without_birds?([_ | t]), do: has_day_without_birds?(t)

  def total(list) when list == nil or length(list) == 0, do: 0
  def total([head | tail]), do: head + total(tail)

  def busy_days(list) when list == nil or length(list) == 0, do: 0
  def busy_days([head | tail]) when head >= 5, do: 1 + busy_days(tail)
  def busy_days([_head | tail]), do: busy_days(tail)
end
