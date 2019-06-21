defmodule CveSync do
  @moduledoc """
  Documentation for CveSync.
  """

  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://nvd.nist.gov/feeds/json/cve/1.0/")

  def fetch(filename) do
    {:ok, env} = get(filename)
    %Tesla.Env{body: body, status: 200} = env
    body
  end

  def fetch_json(filename) do
    [fetch(filename)]
    |> StreamGzip.gunzip()
  end

  def parse_cve(cve = %{"configurations" => %{"CVE_data_version" => "4.0"}}) do
    assigner = cve["cve"]["CVE_data_meta"]["ASSIGNER"]
    cve_number = cve["cve"]["CVE_data_meta"]["ID"]

    {assigner, cve_number}
  end
end
