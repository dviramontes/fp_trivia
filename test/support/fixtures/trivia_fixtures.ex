defmodule FpTrivia.TriviaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FpTrivia.Trivia` context.
  """

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        category: "some category",
        question: "some question",
        rank: 42
      })
      |> FpTrivia.Trivia.create_question()

    question
  end
end
