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
    %{id: cve["cve"]["CVE_data_meta"]["ID"],
      assigner: cve["cve"]["CVE_data_meta"]["ASSIGNER"],
      affected: cve["cve"]["affects"]["vendor"]["vendor_data"],
      description: nil, #TODO Filter out English language desc
      last_modified_date: cve["lastModifiedDate"],
      published_date: cve["publishedDate"]
     }
  end
end
