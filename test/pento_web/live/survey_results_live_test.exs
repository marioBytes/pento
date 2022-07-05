defmodule PentoWeb.SurveyResultsLiveTest do
  use Pento.DataCase

  alias PentoWeb.Admin.SurveyResultsLive
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

  defp create_demographic(user) do
    demographic = demographic_fixture(user)
    %{demographic: demographic}
  end

  defp create_socket(_) do
    %{socket: %Phoenix.LiveView.Socket{}}
  end

  describe "Socket state" do
    setup [:create_user, :create_product, :create_socket]

    setup %{user: user} do
      create_demographic(user)
      user2 = user_fixture(@create_user2_attrs)
      demographic_fixture(user2, @create_demographic2_attrs)
      [user2: user2]
    end

    test "no ratings exist", %{socket: socket} do
      socket =
        socket
        |> SurveyResultsLive.assign_age_group_filter()
        |> SurveyResultsLive.assign_gender_group_filter()
        |> SurveyResultsLive.assign_products_with_average_ratings()

      assert socket.assigns.products_with_average_ratings == [{"Test Game", 0}]
    end

    test "ratings exist", %{socket: socket, product: product, user: user} do
      create_rating(2, user, product)
      socket =
        socket
        |> SurveyResultsLive.assign_age_group_filter()
        |> SurveyResultsLive.assign_gender_group_filter()
        |> SurveyResultsLive.assign_products_with_average_ratings()

      assert socket.assigns.products_with_average_ratings == [{"Test Game", 2.0}]
    end

    test "ratings are filtered by age group", %{
      socket: socket,
      user: user,
      product: product,
      user2: user2
    } do
      create_rating(2, user, product)
      create_rating(3, user2, product)

      socket
      |> SurveyResultsLive.assign_age_group_filter()
      |> assert_keys(:age_group_filter, "all")
      |> update_socket(:age_group_filter, "18 and under")
      |> SurveyResultsLive.assign_age_group_filter()
      |> assert_keys(:age_group_filter, "18 and under")
      |> SurveyResultsLive.assign_gender_group_filter()
      |> SurveyResultsLive.assign_products_with_average_ratings()
      |> assert_keys(:products_with_average_ratings, [{"Test Game", 2.0}])
    end

    defp update_socket(socket, key, value) do
      %{socket | assigns: Map.merge(socket.assigns, Map.new([{key, value}]))}
    end

    defp assert_keys(socket, key, value) do
      assert socket.assigns[key] == value
      socket
    end
  end
end
