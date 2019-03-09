use Mix.Config

config :exvcr,
  filter_request_headers: [
    "APCA-API-KEY-ID",
    "APCA-API-SECRET-KEY"
  ],
  filter_sensitive_data: []
