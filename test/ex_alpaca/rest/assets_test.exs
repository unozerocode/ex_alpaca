defmodule ExAlpaca.Rest.AssetsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExAlpaca.Rest.HTTPClient

  setup_all do
    HTTPoison.start()
    :ok
  end

  @credentials %ExAlpaca.Credentials{
    key_id: System.get_env("ALPACA_KEY_ID"),
    secret_key: System.get_env("ALPACA_SECRET_KEY")
  }

  test ".all returns a list of assets" do
    use_cassette "rest/assets/all_ok" do
      assert {:ok, assets} = ExAlpaca.Rest.Assets.all(%{}, @credentials)
      assert [%ExAlpaca.Asset{} = asset | _] = assets
      assert asset.id != nil
    end
  end
end
