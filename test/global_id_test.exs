defmodule Repo do
  use Ecto.Repo,
    adapter: Ecto.Adapters.Postgres,
    otp_app: :global_id
end

defmodule GlobalIDTest do
  use ExUnit.Case, async: true

  @param {:parameterized, GlobalID, "user_"}

  test "it works" do
    id = "user_9tt-W36iV_yt7JEi"
    assert Ecto.Type.cast(@param, id) == {:ok, id}
    assert Ecto.Type.dump(@param, id) == {:ok, id}
    assert Ecto.Type.load(@param, id) == {:ok, id}

    assert Ecto.Type.cast(@param, "bad") == :error
    assert Ecto.Type.dump(@param, "bad") == :error
    assert Ecto.Type.load(@param, "bad") == :error
  end

  test "nil" do
    assert Ecto.Type.cast(@param, nil) == {:ok, nil}
    assert Ecto.Type.dump(@param, nil) == {:ok, nil}
    assert Ecto.Type.load(@param, nil) == {:ok, nil}
  end

  defmodule User do
    use Ecto.Schema

    schema "users" do
      field(:global_id, GlobalID, prefix: "user_", autogenerate: true)
    end
  end

  test "autogenerate" do
    {:ok, _} = Repo.start_link(database: System.fetch_env!("USER"), pool_size: 1)
    Repo.query!("CREATE TEMPORARY TABLE users (id serial, global_id text not null)")

    user = Repo.insert!(%User{})
    assert "user_" <> _ = user.global_id
    assert Ecto.Type.dump(@param, user.global_id) == {:ok, user.global_id}
    [user] = Repo.all(User)
    assert "user_" <> _ = user.global_id
  end
end
