defmodule Duplo do
  @moduledoc ~S"""
    HTML module that defines all common HTML tags as function for convenience usage

    ## Example

    ```
    iex> Duplo.div([], [
      Duplo.h1([], "Title"),
      Duplo.p([], [
        Duplo.ul([], [
          Duplo.li([], "Item 1"),
          Duplo.li([], "Item 2"),
        ])
      ]),
    ])
    ```
  """
  use Duplo.Tag, [
    :text,
    :node,
    :map,
    :h1,
    :h2,
    :h3,
    :h4,
    :h5,
    :h6,
    :div,
    :p,
    :hr,
    :pre,
    :blockquote,
    :span,
    :a,
    :code,
    :em,
    :strong,
    :i,
    :b,
    :u,
    :sub,
    :sup,
    :br,
    :ol,
    :ul,
    :li,
    :dl,
    :dt,
    :dd,
    :img,
    :iframe,
    :canvas,
    :math,
    :form,
    :input,
    :textarea,
    :button,
    :select,
    :option,
    :section,
    :nav,
    :article,
    :aside,
    :header,
    :footer,
    :address,
    :main_,
    :figure,
    :figcaption,
    :table,
    :caption,
    :colgroup,
    :col,
    :tbody,
    :thead,
    :tfoot,
    :tr,
    :td,
    :th,
    :fieldset,
    :legend,
    :label,
    :datalist,
    :optgroup,
    :output,
    :progress,
    :meter,
    :audio,
    :video,
    :source,
    :track,
    :embed,
    :object,
    :param,
    :ins,
    :del,
    :small,
    :cite,
    :dfn,
    :abbr,
    :time,
    :var,
    :samp,
    :kbd,
    :s,
    :q,
    :mark,
    :ruby,
    :rt,
    :rp,
    :bdi,
    :bdo,
    :wbr,
    :details,
    :summary,
    :menuitem,
    :menu
  ]
end
