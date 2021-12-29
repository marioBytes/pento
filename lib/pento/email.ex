defmodule Pento.Email do
  import Swoosh.Email

  def welcome_email(user) do
    new()
    |> to({user.name, user.email})
    |> from({"Support", "andresmart92@gmail.com"})
    |> subject("Welcome to Pento!")
    |> html_body("<h1>Welcome to Pento, #{user.name}!</h1>")
  end
end
