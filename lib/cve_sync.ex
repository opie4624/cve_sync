defmodule CveSync do
  @moduledoc """
  Documentation for CveSync.
  """

  alias CveSync.{Downloader, Parser}

  def seed_database do
    get_current_year()
    |> create_year_range()
    |> create_filename_list()
    |> fetch_filenames()
    |> parse_cves()
    |> insert_into_db()
  end

  defp get_current_year do
    today =
      DateTime.utc_now()
      |> DateTime.to_date()

    today.year
  end

  defp create_year_range(this_year), do: 2002..this_year

  defp create_filename_list(years),
    do: Enum.map(years, fn x -> "nvdcve-1.1-" <> to_string(x) <> ".json.gz" end)

  defp fetch_filenames(filenames), do: Enum.map(filenames, &Downloader.fetch(&1))

  defp parse_cves(download_streams),
    do:
      download_streams
      |> Enum.reject(&is_error(&1))
      |> Enum.map(&extract_cve_lists(&1))
      |> Enum.concat()
      |> Enum.map(&Parser.parse_cve(&1))

  defp insert_into_db(cves), do: CveSync.Db.Cve.insert(cves)

  defp extract_cve_lists(stream),
    do:
      stream
      |> Jaxon.Stream.from_enumerable()
      |> Jaxon.Stream.query([:root, "CVE_Items", :all])

  defp is_error({:error, _filename}), do: true
  defp is_error(_), do: false

  def start(_), do: start()
  def start(), do: Memento.Table.create(CveSync.Db.Cve)
end
