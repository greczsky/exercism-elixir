defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      legacy? and (level == 0 or level == 5) -> :unknown
      level == 0 -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    level = to_label(level, legacy?)

    cond do
      level in [:error, :fatal] -> :ops
      level == :unknown and legacy? -> :dev1
      level == :unknown -> :dev2
      true -> false
    end
  end
end
