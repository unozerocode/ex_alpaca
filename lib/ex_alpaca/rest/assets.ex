defmodule ExAlpaca.Rest.Assets do
  alias ExAlpaca.Rest

  def all(params, %ExAlpaca.Credentials{} = credentials) do
    "/assets"
    |> Rest.HTTPClient.get(params, credentials)
    |> parse_response
  end

  defp parse_response({:ok, data}) do
    assets =
      data
      |> Enum.map(&Mapail.map_to_struct(&1, ExAlpaca.Asset))
      |> Enum.map(fn {:ok, a} -> a end)

    {:ok, assets}
  end
end
