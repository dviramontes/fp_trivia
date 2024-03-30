defmodule FpTrivia.TriviaTest do
  use FpTrivia.DataCase

  alias FpTrivia.Trivia

  describe "questions" do
    alias FpTrivia.Trivia.Question

    import FpTrivia.TriviaFixtures

    @invalid_attrs %{category: nil, question: nil, rank: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Trivia.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Trivia.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{category: "some category", question: "some question", rank: 42}

      assert {:ok, %Question{} = question} = Trivia.create_question(valid_attrs)
      assert question.category == "some category"
      assert question.question == "some question"
      assert question.rank == 42
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trivia.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{category: "some updated category", question: "some updated question", rank: 43}

      assert {:ok, %Question{} = question} = Trivia.update_question(question, update_attrs)
      assert question.category == "some updated category"
      assert question.question == "some updated question"
      assert question.rank == 43
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Trivia.update_question(question, @invalid_attrs)
      assert question == Trivia.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Trivia.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Trivia.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Trivia.change_question(question)
    end
  end
end
