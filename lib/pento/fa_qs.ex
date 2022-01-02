defmodule Pento.FAQs do
  import Ecto.Query, warn: false
  alias Pento.Repo

  alias Pento.FAQs.FAQ

  def list_faqs do
    Repo.all(FAQ)
  end

  def get_faq!(id), do: Repo.get!(FAQ, id)

  def create_faq(attrs \\ %{}) do
    attrs = Map.put(attrs, "vote_count", 0)
    %FAQ{}
    |> FAQ.changeset(attrs)
    |> Repo.insert()
  end

  def increment_faq(%FAQ{} = faq, attrs) do
    faq
    |> FAQ.changeset(attrs)
    |> Repo.update()
  end

  def update_faq(%FAQ{} = faq, attrs) do
    faq
    |> FAQ.changeset(attrs)
    |> Repo.update()
  end

  def delete_faq(%FAQ{} = faq) do
    Repo.delete(faq)
  end

  def change_faq(%FAQ{} = faq, attrs \\ %{}) do
    FAQ.changeset(faq, attrs)
  end
end
