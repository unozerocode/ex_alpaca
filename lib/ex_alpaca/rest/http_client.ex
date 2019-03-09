defmodule ExAlpaca.Rest.HTTPClient do
  @endpoint Application.get_env(:ex_alpaca, :endpoint, "https://api.alpaca.markets")
  @api_path Application.get_env(:ex_alpaca, :api_path, "/v1")

  def get(path, params, credentials) do
    request(:get, path, params, credentials)
  end

  def request(verb, path, params, credentials) do
    body = Jason.encode!(params)

    headers =
      credentials
      |> auth_headers()
      |> put_content_type(:json)

    %HTTPoison.Request{
      method: verb,
      url: path |> url,
      headers: headers,
      body: body
    }
    |> send
  end

  @spec url(path :: String.t()) :: String.t()
  def url(path), do: @endpoint <> @api_path <> path

  defp send(request) do
    request
    |> HTTPoison.request()
    |> parse_response
  end

  defp auth_headers(credentials) do
    ["APCA-API-KEY-ID": credentials.key_id, "APCA-API-SECRET-KEY": credentials.secret_key]
  end

  defp put_content_type(headers, :json) do
    Keyword.put(headers, :"Content-Type", "application/json")
  end

  defp parse_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    data = Jason.decode!(body)
    {:ok, data}
  end
end
