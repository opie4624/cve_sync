defmodule CveSync.Parser do
  def parse_cve(cve = %{"configurations" => %{"CVE_data_version" => "4.0"}}) do
    %{
      id: cve["cve"]["CVE_data_meta"]["ID"],
      assigner: cve["cve"]["CVE_data_meta"]["ASSIGNER"],
      affected: cve["cve"]["affects"]["vendor"]["vendor_data"],
      # TODO Filter out English language desc
      description: nil,
      last_modified_date: cve["lastModifiedDate"],
      published_date: cve["publishedDate"]
    }
  end
end
