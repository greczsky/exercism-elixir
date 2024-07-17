defmodule HighSchoolSweetheart do
  import String

  def first_letter(name) do
    name |> trim |> first
  end

  def initial(name) do
    name |> first_letter |> capitalize |> Kernel.<>(".")
  end

  def initials(full_name) do
    full_name |> split |> Enum.map(fn x -> initial(x) end) |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    """
         ******       ******
       **      **   **      **
     **         ** **         **
  **            *            **
  **                         **
  **     #{initials(full_name1)}  +  #{initials(full_name2)}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """

    # Please implement the pair/2 function
  end
end
