defmodule CircularBuffer do
  use GenServer

  @moduledoc """
  An API to a stateful process that fills and empties a circular buffer
  """

  @doc """
  Create a new buffer of a given capacity
  """
  @spec new(capacity :: integer) :: {:ok, pid}
  def new(capacity) do
    GenServer.start_link(__MODULE__, capacity)
  end

  @doc """
  Read the oldest entry in the buffer, fail if it is empty
  """
  @spec read(buffer :: pid) :: {:ok, any} | {:error, atom}
  def read(buffer) do
    GenServer.call(buffer, :read)
  end

  @doc """
  Write a new item in the buffer, fail if is full
  """
  @spec write(buffer :: pid, item :: any) :: :ok | {:error, atom}
  def write(buffer, item) do
    GenServer.call(buffer, {:write, item})
  end

  @doc """
  Write an item in the buffer, overwrite the oldest entry if it is full
  """
  @spec overwrite(buffer :: pid, item :: any) :: :ok
  def overwrite(buffer, item) do
    GenServer.call(buffer, {:overwrite, item})
  end

  @doc """
  Clear the buffer
  """
  @spec clear(buffer :: pid) :: :ok
  def clear(buffer) do
    GenServer.cast(buffer, :clear)
  end

  @impl GenServer
  def init(init_arg) do
    {:ok, {init_arg, []}}
  end

  @impl GenServer
  def handle_call(:read, _from, {_, []} = state) do
    {:reply, {:error, :empty}, state}
  end

  @impl GenServer
  def handle_call(:read, _from, {capacity, buffer}) do
    {last, new_state} = List.pop_at(buffer, -1)
    {:reply, {:ok, last}, {capacity, new_state}}
  end

  @impl GenServer
  def handle_call({:write, _item}, _from, {capacity, buffer}) when length(buffer) == capacity do
    {:reply, {:error, :full}, {capacity, buffer}}
  end

  @impl GenServer
  def handle_call({:write, item}, _from, {capacity, buffer}) do
    {:reply, :ok, {capacity, [item | buffer]}}
  end

  @impl GenServer
  def handle_call({:overwrite, item}, _from, {capacity, buffer})
      when length(buffer) == capacity do
    new_buffer = List.delete_at(buffer, -1)
    {:reply, :ok, {capacity, [item | new_buffer]}}
  end

  @impl GenServer
  def handle_call({:overwrite, item}, _from, {capacity, buffer}) do
    {:reply, :ok, {capacity, [item | buffer]}}
  end

  @impl GenServer
  def handle_cast(:clear, {capacity, _buffer}) do
    {:noreply, {capacity, []}}
  end
end
