defmodule HighScore do
  @initial_score 0

  def new() do
    %{}
  end

  def add_player(scores, name, score \\ @initial_score) do
    Map.put(scores, name, score)
  end

  def remove_player(scores, name) do
    {_, new_scores} = Map.pop(scores, name)
    new_scores
  end

  def reset_score(scores, name) do
    cond do
      Map.has_key?(scores, name) ->
        %{scores | name => @initial_score}

      true ->
        add_player(scores, name, @initial_score)
    end
  end

  def update_score(scores, name, score) do
    Map.update(scores, name, score, &(&1 + score))
  end

  def get_players(scores) do
    Map.keys(scores)
  end
end
