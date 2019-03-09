defmodule ExAlpaca.Credentials do
  @enforce_keys ~w(key_id secret_key)a
  defstruct ~w(key_id secret_key)a
end
