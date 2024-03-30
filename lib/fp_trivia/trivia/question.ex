defmodule FpTrivia.Trivia.Question do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    field :category, :string
    field :question, :string
    field :rank, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:question, :category, :rank])
    |> validate_required([:question, :category, :rank])
  end
end
