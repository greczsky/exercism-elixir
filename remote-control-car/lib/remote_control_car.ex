defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none") do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance_driven_in_meters}) do
    "#{distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: battery_percentage}) do
    case battery_percentage do
      0 -> "Battery empty"
      _ -> "Battery at #{battery_percentage}%"
    end
  end

  def drive(
        %RemoteControlCar{
          battery_percentage: 0
        } = remote_car
      ),
      do: remote_car

  def drive(
        %RemoteControlCar{
          battery_percentage: battery_percentage,
          distance_driven_in_meters: distance_driven_in_meters
        } = remote_car
      ) do
    %RemoteControlCar{
      remote_car
      | distance_driven_in_meters: distance_driven_in_meters + 20,
        battery_percentage: battery_percentage - 1
    }
  end
end
