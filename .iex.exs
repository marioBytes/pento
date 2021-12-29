alias Pento.{
  Catalog,
  Repo,
  User
}
alias Pento.Catalog.Product

user = %{name: "Mario", email: "andresmart92@gmail.com"}
email = Pento.Email.welcome_email(user)
