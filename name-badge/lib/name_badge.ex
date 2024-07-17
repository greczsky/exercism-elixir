defmodule NameBadge do
  def print(id, name, department) do
    suffix = if department, do: String.upcase(department), else: "OWNER"

    if id do
      "[#{id}] - #{name} - #{suffix}"
    else
      "#{name} - #{suffix}"
    end
  end
end
