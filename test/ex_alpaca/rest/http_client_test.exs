defmodule ExAlpaca.Rest.HTTPClientTest do
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

  test ".request returns an ok tuple with the parsed json data" do
    use_cassette "rest/http_client/request_ok" do
      assert {:ok, assets} = ExAlpaca.Rest.HTTPClient.request(:get, "/assets", %{}, @credentials)

      assert [%{} = _ | _] = assets
    end
  end
end
