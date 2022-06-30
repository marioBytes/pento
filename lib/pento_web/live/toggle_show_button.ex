defmodule PentoWeb.ButtonLive do
  use Phoenix.Component
  use Phoenix.HTML

  def button(assigns) do
    ~H"""
      <button phx-click="toggle-content">
        <%= render_slot(@inner_block) %>
      </button>
    """
  end
end
