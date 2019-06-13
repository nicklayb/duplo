defmodule Duplo.Tag do
  @moduledoc ~S"""
    Defines tag rendering function inside of a module for convenience. Intended to be used with a list of atom as function to define

    ## Example

    ```
    defmodule Module do
      use Duplo.Tag, [:div, :span]  # Defines div/2 and span/2
    end

    iex> TagTest.Module.div(class: "button")
    "<div class=\"button\"></div>"

    iex> TagTest.Module.span(class: "button")
    "<span class=\"button\"></span>"
    ```
  """

  @doc ~S"""
    Render a specific tag with given attrs and children

    ## Example

    ```
    iex> Duplo.Tag.render_tag("master-tag", [special_attr: "A value"], ["Child"])
    "<master-tag special-attr=\"A value\">Child</master-tag>"
    ```
  """
  @spec render_tag(atom() | bitstring()) :: String.t()
  def render_tag(tag), do: render_tag(tag, [])

  @spec render_tag(atom() | bitstring(), [any()]) :: String.t()
  def render_tag(tag, attrs), do: render_tag(tag, attrs, [])

  @spec render_tag(atom() | bitstring(), [any()], any()) :: String.t()
  def render_tag(tag, attrs, children) when is_atom(tag),
    do: render_tag(Atom.to_string(tag), attrs, children)

  def render_tag(tag, attrs, children) when is_bitstring(tag) do
    open_tag =
      [tag, render_attributes(attrs)]
      |> Enum.filter(fn string -> String.length(string) > 0 end)
      |> Enum.join(" ")

    "<#{open_tag}>#{render_children(children)}</#{tag}>"
  end

  @doc ~S"""
    Format a list of attributes to be output in HTML. It dashes the key ("HelloWorld" key becomes "hello-world") and sanitize the value

    ## Examples
    ```
    iex> Duplo.Tag.render_attributes([class: "btn btn-xs btn-primary"])
    "class=\"btn btn-xs btn-primary\""
    ```
  """
  @spec render_attributes([{atom(), String.t()}]) :: String.t()
  def render_attributes(attrs) do
    attrs
    |> Enum.map(&Duplo.Attr.attr/1)
    |> Enum.join(" ")
  end

  @doc ~S"""
    Renders children, you can either give a string or a list of string

    ## Examples
    ```
    iex> Duplo.Tag.render_children("A text")
    "A text"

    iex> Duplo.Tag.render_children(["A text", "And another one"])
    "A textAnd another one"
    ```
  """
  @spec render_children(any()) :: String.t()
  def render_children(children) when is_list(children), do: Enum.join(children)
  def render_children(children), do: children

  defmacro __using__(tags) do
    attr =
      quote do
        import Duplo.Tag

        @doc ~S"""
          Returns available tags as an atom list

          ## Example

          iex> #{__MODULE__}.tags()
          [:#{Enum.join(unquote(tags), ", :")}]
        """
        def tags(), do: unquote(tags)
      end

    tags =
      Enum.map(tags, fn tag ->
        quote do
          @doc ~S"""
            Returns a <#{unquote(tag)} tag with given attributes and childrens. Both mush be arrays

            ## Example

            iex> #{__MODULE__}.#{unquote(tag)}()
            "<#{unquote(tag)} ></#{unquote(tag)}>"

            iex> #{__MODULE__}.#{unquote(tag)}(class: "btn")
            "<#{unquote(tag)} class=\"btn\"></#{unquote(tag)}>"

            iex> #{__MODULE__}.#{unquote(tag)}(class: "btn", ["Hello"])
            "<#{unquote(tag)} class=\"btn\">Hello</#{unquote(tag)}>"
          """
          def unquote(tag)(attrs \\ [], children \\ []) do
            render_tag(unquote(tag), attrs, children)
          end
        end
      end)

    [attr | tags]
  end
end
