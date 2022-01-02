defmodule PentoWeb.FAQLive.Show do
  use PentoWeb, :live_view

  alias Pento.FAQs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:faq, FAQs.get_faq!(id))}
  end

  defp page_title(:show), do: "Show Faq"
  defp page_title(:edit), do: "Edit Faq"
end
