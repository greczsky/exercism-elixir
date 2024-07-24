defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    for top <- tops,
        bottom <- bottoms,
        top.base_color != bottom.base_color and
          (options[:maximum_price] || 100) > top.price + bottom.price do
      {top, bottom}
    end
  end
end
