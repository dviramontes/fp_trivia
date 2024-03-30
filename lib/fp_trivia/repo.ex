defmodule FpTrivia.Repo do
  use Ecto.Repo,
    otp_app: :fp_trivia,
    adapter: Ecto.Adapters.SQLite3
end
