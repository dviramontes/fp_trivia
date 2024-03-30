defmodule FpTrivia.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :question, :text
      add :category, :string
      add :rank, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
