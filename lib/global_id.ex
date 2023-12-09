defmodule GlobalID do
  use Ecto.ParameterizedType

  @impl true
  def type(_prefix), do: :string

  @impl true
  def autogenerate(prefix) do
    prefix <> Base.url_encode64(:crypto.strong_rand_bytes(12))
  end

  @impl true
  def init(options) do
    Keyword.fetch!(options, :prefix)
  end

  @impl true
  def cast(data, prefix) do
    dump(data, nil, prefix)
  end

  @impl true
  def load(data, _loader, prefix) do
    dump(data, nil, prefix)
  end

  @impl true
  def dump(nil, _dumper, _prefix) do
    {:ok, nil}
  end

  def dump(id, _dumper, prefix) when is_binary(id) do
    with ^prefix <> <<rest::binary-size(16)>> <- id,
         {:ok, _} <- Base.url_decode64(rest) do
      {:ok, id}
    else
      _ -> :error
    end
  end
end
