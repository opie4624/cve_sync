defmodule CveSync.Downloader do
  use Tesla

  adapter(Tesla.Adapter.Mint)

  plug(Tesla.Middleware.BaseUrl, "https://nvd.nist.gov/feeds/json/cve/1.1/")

  def fetch_example(year \\ 2020) do
    fetch("nvdcve-1.1-#{year}.json.gz")
  end

  def fetch(filename) do
    case get(filename, headers: [{"Accept-Encoding", "gzip"}]) do
      {:ok, %Tesla.Env{body: body, status: 200}} ->
        StreamGzip.gunzip([body])

      _error ->
        {:error, filename}
    end
  end
end
