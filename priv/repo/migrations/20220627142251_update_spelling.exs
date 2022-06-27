defmodule Pento.Repo.Migrations.UpdateSpelling do
  use Ecto.Migration

  def change do
    rename table(:ratings), :starts, to: :stars
  end
end
