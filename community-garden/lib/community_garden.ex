# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start_link(fn -> %{plots: [], next_id: 1} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, & &1.plots)
  end

  def register(pid, register_to) do
    Agent.get_and_update(
      pid,
      fn %{plots: plots, next_id: next_id} ->
        plot = %Plot{plot_id: next_id, registered_to: register_to}

        {plot,
         %{
           plots: [
             plot | plots
           ],
           next_id: next_id + 1
         }}
      end
    )
  end

  def release(pid, plot_id) do
    Agent.cast(pid, fn %{plots: plots} = state ->
      %{
        state
        | plots: Enum.filter(plots, fn %{plot_id: id} -> id != plot_id end)
      }
    end)
  end

  def get_registration(pid, plot_id) do
    list_registrations(pid)
    |> Enum.find({:not_found, "plot is unregistered"}, fn plot -> plot.plot_id == plot_id end)
  end
end
