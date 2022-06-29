defmodule PentoWeb.RatingLive.Index do
  use Phoenix.Component
  use Phoenix.HTML

  alias PentoWeb.RatingLive
  alias PentoWeb.RatingLive.Show

  def products(assigns) do
    ~H"""
      <div class="survey-component-container">
        <.heading products={@products} />
        <.list products={@products} current_user={@current_user} />
      </div>
    """
  end

  def heading(assigns) do
    ~H"""
      <h2>
        Ratings
        <%= if ratings_complete?(@products), do: raw "&#x2713;" %>
      </h2>
    """
  end

  def list(assigns) do
    ~H"""
      <%= for {product, index} <- Enum.with_index(@products) do %>
        <%= if rating = List.first(product.ratings) do %>
          <Show.stars rating={rating} product={product} />
        <% else %>
          <.live_component
            module={RatingLive.Form}
            id={"rating-form-#{product.id}"}
            product={product}
            product_index={index}
            current_user={@current_user}
          />
        <% end %>
      <% end %>
    """
  end

  defp ratings_complete?(products) do
    Enum.all?(products, fn product -> Enum.empty?(product.ratings) end)
  end
end
