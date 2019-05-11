defmodule Duplo.Attr do
  @doc ~S"""
    Format an attribute to be output in HTML. It dashes the key ("HelloWorld" key becomes "hello-world") and sanitize the value

    ## Examples
    ```
    iex> Duplo.Attr.attr({:class, "btn btn-xs btn-primary"})
    "class=\"btn btn-xs btn-primary\""

    iex> Duplo.Attr.attr({"style", "background-color: red;"})
    "style=\"background-color: red;\""
    ```
  """
  @spec attr({atom() | bitstring(), String.t()}) :: String.t()
  def attr({key, value}) when is_atom(key), do: attr({Atom.to_string(key), value})
  def attr({key, value}), do: "#{dasherize(key)}=\"#{sanitize(value)}\""

  defp dasherize(str) do
    str
    |> Macro.underscore()
    |> String.replace("_", "-")
  end

  defp sanitize(value), do: String.replace(value, "\"", "\\\"")
end
