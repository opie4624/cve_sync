defmodule CveSync.Db.Cve do
  use Memento.Table,
    attributes: [:id, :assigner, :description, :last_modified_date, :published_date, :raw]

  alias __MODULE__

  def insert(cve = %Cve{}) do
    Memento.transaction(fn -> insert!(cve) end)
  end

  def insert(cve) when is_list(cve) do
    Memento.transaction(fn ->
      Enum.map(cve, &cast(&1))
      |> Enum.map(&insert!(&1))
    end)
  end

  defp insert!(cve = %Cve{}) do
    Memento.Query.write(cve)
  end

  def get(cves) when is_list(cves) do
    Memento.transaction(fn ->
      Enum.map(cves, &read!(&1))
    end)
  end

  def get(cve_id) do
    Memento.transaction(fn ->
      read!(cve_id)
    end)
  end

  def read!(id), do: Memento.Query.read(__MODULE__, id)

  def cast(%{
        id: id,
        assigner: assigner,
        description: description,
        last_modified_date: last_modified_date,
        published_date: published_date,
        raw: cve_raw
      }),
      do: %Cve{
        id: id,
        assigner: assigner,
        description: description,
        last_modified_date: last_modified_date,
        published_date: published_date,
        raw: cve_raw
      }
end
