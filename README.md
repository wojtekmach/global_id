# GlobalID

An [`Ecto.ParameterizedType`](https://hexdocs.pm/ecto/Ecto.ParameterizedType.html) for prefixed random IDs.

This is a WIP.

## Usage

```elixir
Mix.install([
  {:global_id, github: "wojtekmach/global_id"}
])

defmodule User do
  use Ecto.Schema

  schema "users" do
    field(:global_id, GlobalID, prefix: "user_", autogenerate: true)
  end
end
```

```elixir
iex> user = Repo.insert!(%User{})
iex> user.global_id
"user_SJajdjKBnBEBU-CF"
```

## License

Copyright (c) 2024 Wojtek Mach

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
