defmodule PentoWeb.SurveyLive.Component do
  use Phoenix.Component

  def hero(assigns) do
    ~H"""
    <h2>
      content: <%= @content %>
    </h2>
    <h3>
      slot: <%= render_slot(@inner_block) %>
    </h3>
    """
  end
end
