defmodule HelloAll.Repo do
  use Ecto.Repo,
    otp_app: :hello_all,
    adapter: Ecto.Adapters.Postgres
end
