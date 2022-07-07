defmodule PentoWeb.RatingLiveTest do
  use PentoWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Pento.{Accounts, Catalog, Survey}

  @create_product_attrs %{
    description: "test description",
    name: "Test Game",
    sku: 42,
    unit_price: 120.5
  }
  @create_user_attrs %{
    email: "test@test.com",
    password: "passwordpassword"
  }
  @create_user2_attrs %{
    email: "another-person@email.com",
    password: "passwordpassword"
  }
  @create_demographic_attrs %{
    gender: "female",
    year_of_birth: DateTime.utc_now().year - 15
  }
  @create_demographic2_attrs %{
    gender: "male",
    year_of_birth: DateTime.utc_now().year - 30
  }

  defp product_fixture() do
    {:ok, product} = Catalog.create_product(@create_product_attrs)
    product
  end

  defp user_fixture(attrs \\ @create_user_attrs) do
    {:ok, user} = Accounts.register_user(attrs)
    user
  end

  defp demographic_fixture(user, attrs \\ @create_demographic_attrs) do
    attrs =
      attrs
      |> Map.merge(%{user_id: user.id})

    {:ok, demographic} = Survey.create_demographic(attrs)
    demographic
  end

  defp rating_fixture(stars, user, product) do
    {:ok, rating} =
      Survey.create_rating(%{stars: stars, user_id: user.id, product_id: product.id})

    rating
  end

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end

  defp create_rating(stars, user, product) do
    rating = rating_fixture(stars, user, product)
    %{rating: rating}
  end

  defp create_demographic(user, attrs \\ @create_demographic_attrs) do
    demographic = demographic_fixture(user, attrs)
    %{demographic: demographic}
  end

  describe "Rating component state" do
    setup [:register_and_log_in_user, :create_product, :create_user]

    setup %{user: user, product: product} do
      create_demographic(user)

      user2 = user_fixture(@create_user2_attrs)
      create_demographic(user2, @create_demographic2_attrs)
      create_rating(4, user2, product)
      :ok
    end

    test "Form component rendered when rating does not exist", %{user: user, product: product} do
      assert render_component(&PentoWeb.RatingLive.Index.products/1, products: [], current_user: user) =~ "<div class=\"survey-component-container\">\n    <h2>\n    Ratings\n    &#x2713;\n  </h2>\n    \n  </div>"
    end
  end
end
