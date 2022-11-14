defmodule TimeManager.Repo do
  use Ecto.Repo,
    otp_app: :time_manager,
    adapter: Ecto.Adapters.Postgres

    def init(_, config) do
      config = config
        |> Keyword.put(:username, System.get_env("PGUSER") || "postgres")
        |> Keyword.put(:password, System.get_env("PGPASSWORD") || "root")
        |> Keyword.put(:database, System.get_env("PGDATABASE") || "localhost")
        |> Keyword.put(:hostname, System.get_env("PGHOST") || "new_time_manager_dev")
        |> Keyword.put(:port, System.get_env("PGPORT") |> String.to_integer || 5432)
      {:ok, config}
    end
end
