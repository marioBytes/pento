defmodule Pento.FAQsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.FAQs` context.
  """

  @doc """
  Generate a faq.
  """
  def faq_fixture(attrs \\ %{}) do
    {:ok, faq} =
      attrs
      |> Enum.into(%{
        answer: "some answer",
        question: "some question",
        vote_count: 42
      })
      |> Pento.FAQs.create_faq()

    faq
  end
end
