defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    child = spawn_link(fn -> calculator.(input) end)
    %{pid: child, input: input}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    orig_value = Process.flag(:trap_exit, true)

    Enum.map(inputs, &start_reliability_check(calculator, &1))
    |> Enum.reduce(%{}, &await_reliability_check_result/2)
    |> tap(fn _ -> Process.flag(:trap_exit, orig_value) end)
  end

  def correctness_check(calculator, inputs) do
    for input <- inputs do
      Task.async(fn -> calculator.(input) end)
    end
    |> Task.await_many(100)
  end
end
