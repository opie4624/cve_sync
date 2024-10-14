defmodule CveSync.Parser do
  def parse_cve(cve = %{"configurations" => %{"CVE_data_version" => "4.0"}}) do
    %{
      id: cve["cve"]["CVE_data_meta"]["ID"],
      assigner: cve["cve"]["CVE_data_meta"]["ASSIGNER"],
      affected: cve["cve"]["affects"]["vendor"]["vendor_data"],
      description: get_description(cve["cve"]["description"]["description_data"]),
      last_modified_date: cve["lastModifiedDate"],
      published_date: cve["publishedDate"],
      raw: cve
    }
  end

  defp get_description(descr_data) when is_list(descr_data) do
    [%{"lang" => "en", "value" => description} | _tail] = descr_data
    description
  end

  defp get_description(_), do: nil
end
