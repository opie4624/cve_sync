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

  defp parse_cves(x), do: x

  defp insert_into_db(x), do: x
end
