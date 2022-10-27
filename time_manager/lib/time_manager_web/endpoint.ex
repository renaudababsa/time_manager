defmodule TimeManagerWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :time_manager

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_time_manager_key",
    signing_salt: "goL9Artq"
  ]

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :time_manager,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :time_manager
  end

  # Configure cors for the application
  # plug Corsica, origin: "*",
  #   methods: [:get, :post, :put, :delete, :options],
  #   headers: ["accept", "content-type", "origin", "authorization", "accept-encoding", "accept-language", "host", "referer", "user-agent", "x-requested-with", "x-csrf-token", "x-forwarded-for", "x-forwarded-proto", "x-forwarded-port", "via", "connect-time", "x-request-start", "total-route-time"],
  #   credentials: true

  #configure cors_plug to allow anything and any method and any header


  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug CORSPlug,
  origins: "*",
  allow_headers: ["accept", "content-type", "authorization", "contenttype"],
  allow_credentials: true,
  log: [rejected: :error, invalid: :warn, accepted: :debug]
  plug TimeManagerWeb.Router
end
