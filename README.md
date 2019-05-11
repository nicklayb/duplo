# Duplo

Duplo is a HTML buiilder based on function calls. Instead of writing whole HTML you can simple call functions.

## Example usage

Instead of

```elixir
defmodule MyModule do
  def render_html(title) do
    "<h1 class="a class I need" some-other-attribute="This get complicated to prevent typos">#{title}</h1>
  end
end
```

It lets you do

```elixir
defmodule MyModule do
  import Duplo

  def render_html(title) do
    h1([
      class: "a class I need",
      some_other_attribute: "Gets easier to read and to maintain"
    ], title)
  end
end
```

## Advanced usage

In fact, the main purpose of this is composing tags. If you want "components" or higher level building blocks, it gets really easy to do.

```elixir
defmodule Bootstrap do
  use Duplo.Tag, [:button, :ul, :li]

  def btn(text, color \\ "primary") do
    button([class: "btn btn-xs btn-#{color}], text)
  end

  @ul_class "list-group"
  @li_class "list-group-item"
  def list(items) do
    ul(
      [class: @ul_class],
      Enum.map(items, fn (item) ->
        li([class: @li_class], item)
      end)
    )
  end
end
```

This would help ensure consistency between element usage over your website

```elixir
defmodule Page do
  import Bootstrap
  use Duplo.Tag, [:div]

  def render() do
    div([], [
      list(["First item", "Second item"])
      btn("Submit form")
    ])
  end
end
```

Page.render/0 would then output

```html
<div >
  <ul class="list-group">
    <li class="list-group-item">First item</li>
    <li class="list-group-item">Second item</li>
  <ul>
  <button class="btn btn-xs btn-primary">Submit form</button>
</div>
```
