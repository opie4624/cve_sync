defmodule CveSync.Parser do
  def parse_cve(cve = %{"configurations" => %{"CVE_data_version" => "4.0"}}) do
    %{
      id: cve["cve"]["CVE_data_meta"]["ID"],
      assigner: cve["cve"]["CVE_data_meta"]["ASSIGNER"],
      affected: cve["cve"]["affects"]["vendor"]["vendor_data"],
      # TODO Filter out English language desc
      description: get_description(cve["cve"]["description"]["description_data"]),
      last_modified_date: cve["lastModifiedDate"],
      published_date: cve["publishedDate"]
    }
  end

  defp get_description(cve) when is_list(cve) do
    [%{"lang" => "en", "value" => description} | _tail] = cve
    description
  end

  defp get_description(_), do: nil
end
