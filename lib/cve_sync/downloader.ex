defmodule CveSync.Downloader do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://nvd.nist.gov/feeds/json/cve/1.1/")

  def fetch(filename) do
    {:ok, env} = get(filename)
    %Tesla.Env{body: body, status: 200} = env

    [body]
    |> StreamGzip.gunzip()
  end
end
