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

  def custom_hero(assigns) do
    ~H"""
      <h1><%= @content %></h1>
    """
  end

  def list_item(assigns) do
    ~H"""
      <li><%= render_slot(@inner_block) %></li>
    """
  end
end
