defmodule TakeANumber do
  def start() do
    spawn(&loop/0)
  end

  defp loop(state \\ 0) do
    receive do
      {:report_state, sender} -> send(sender, state) |> loop()
      {:take_a_number, sender} -> send(sender, state + 1) |> loop()
      :stop -> nil
      _ -> loop(state)
    end
  end
end
