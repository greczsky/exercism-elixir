defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({node_type, _, [first_param | _]} = ast, acc)
      when node_type in [:def, :defp] do
    {name, arity} = decode_fragment(first_param)
    secret = String.slice(name, 0, arity)
    {ast, [secret | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  defp decode_fragment({:when, _, [first_param | _]}), do: decode_fragment(first_param)
  defp decode_fragment({atom, _, nil}), do: {Atom.to_string(atom), 0}
  defp decode_fragment({atom, _, params}), do: {Atom.to_string(atom), length(params)}

  def(decode_secret_message(string)) do
    string
    |> to_ast
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join()
  end
end
