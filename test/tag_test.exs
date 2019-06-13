defmodule TagTest do
  use ExUnit.Case
  alias Duplo.Tag
  doctest Duplo.Tag

  defmodule Module do
    use Duplo.Tag, [:div, :span]
  end

  test "defined tag function" do
    assert "<div></div>" == Builder.div()
  end

  test "defined tag function with attributes" do
    class = "btn and-other-class"
    assert "<div class=\"#{class}\"></div>" == Builder.div(class: class)
  end

  test "defined tag function with attributes and children" do
    class = "btn and-other-class"

    children = [
      Builder.span()
    ]

    assert "<div class=\"#{class}\"><span></span></div>" == Builder.div([class: class], children)
  end

  test "defines tag list" do
    assert [:div, :span, :special] = Builder.tags()
  end

  test "dasherize attribute keys" do
    assert "<div class=\"super-class\" other-attribute=\"1\"></div>" ==
             Builder.div(class: "super-class", other_attribute: "1")
  end

  test "render only tag" do
    assert "<tag></tag>" = Tag.render_tag("tag")
  end

  test "render tag with attributes" do
    assert "<tag style=\"background-color: red;\"></tag>" =
             Tag.render_tag("tag", style: "background-color: red;")
  end

  test "render tag with attributes and children" do
    children = [
      Tag.render_tag("blue")
    ]

    assert "<tag style=\"background-color: red;\"><blue></blue></tag>" =
             Tag.render_tag("tag", [style: "background-color: red;"], children)
  end
end
