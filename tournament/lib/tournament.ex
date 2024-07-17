defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.reduce(%{}, fn item, acc ->
      String.split(item, ";", trim: true) |> process_record(acc)
    end)
    |> Map.values()
    |> Enum.sort(fn {team_1, _, _, _, _, points_1}, {team_2, _, _, _, _, points_2} ->
      points_1 > points_2 or (points_1 == points_2 and team_1 < team_2)
    end)
    |> Enum.reduce("Team                           | MP |  W |  D |  L |  P", fn {name, mp, w, d,
                                                                                  l, p},
                                                                                 acc ->
      acc <>
        "\n#{String.pad_trailing(name, 30)} | #{String.pad_leading(to_string(mp), 2)} |  #{w} |  #{d} |  #{l} | #{String.pad_leading(to_string(p), 2)}"
    end)
  end

  defp process_record([team_1, team_2, "win"], map) do
    map
    |> assign_win(team_1)
    |> assign_lost(team_2)
  end

  defp process_record([team_1, team_2, "loss"], map) do
    map
    |> assign_win(team_2)
    |> assign_lost(team_1)
  end

  defp process_record([team_1, team_2, "draw"], map) do
    map
    |> assign_draw(team_2)
    |> assign_draw(team_1)
  end

  defp process_record(_, map), do: map

  defp assign_win(map, team) do
    {_, mp, w, d, l, p} = Map.get(map, team, {nil, 0, 0, 0, 0, 0})
    Map.put(map, team, {team, mp + 1, w + 1, d, l, p + 3})
  end

  defp assign_lost(map, team) do
    {_, mp, w, d, l, p} = Map.get(map, team, {nil, 0, 0, 0, 0, 0})
    Map.put(map, team, {team, mp + 1, w, d, l + 1, p})
  end

  defp assign_draw(map, team) do
    {_, mp, w, d, l, p} = Map.get(map, team, {nil, 0, 0, 0, 0, 0})
    Map.put(map, team, {team, mp + 1, w, d + 1, l, p + 1})
  end
end
