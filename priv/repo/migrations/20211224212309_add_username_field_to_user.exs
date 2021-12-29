defmodule Pento.Repo.Migrations.AddUsernameFieldToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string
    end
  end
end
