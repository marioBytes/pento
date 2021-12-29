defmodule PentoWeb.UserRegistrationController do
  use PentoWeb, :controller

  alias Pento.{Accounts, Email, Mailer}
  alias Pento.Accounts.User
  alias PentoWeb.UserAuth

  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    username =
      user_params["email"]
      |> String.split("@")
      |> List.first()

    user_params = Map.put_new(user_params, "username", username)

    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
