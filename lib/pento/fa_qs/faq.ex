defmodule Pento.FAQs.FAQ do
  use Ecto.Schema
  import Ecto.Changeset

  schema "faqs" do
    field :answer, :string
    field :question, :string
    field :vote_count, :integer, default: 0

    belongs_to :user, Pento.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(faq, attrs) do
    faq
    |> cast(attrs, [:question, :answer, :vote_count, :user_id])
    |> validate_required([:question, :answer])
  end
end
