defmodule CveSync.Db.Cve do
  use Memento.Table,
    attributes: [:id, :assigner, :description, :last_modified_date, :published_date, :raw]

  import CveSync.Db

  alias __MODULE__
  alias Memento.Query

  def insert(cve = %Cve{}) do
    maybe_transact(fn -> insert!(cve) end)
  end

  def insert(cve) when is_list(cve) do
    maybe_transact(fn ->
      Enum.map(cve, &cast(&1))
      |> Enum.map(&insert!(&1))
    end)
  end

  defp insert!(cve = %Cve{}) do
    maybe_transact(fn ->
      Query.write(cve)
    end)
  end

  def get(cves) when is_list(cves) do
    maybe_transact(fn ->
      Enum.map(cves, &read!(&1))
    end)
  end

  def get(cve_id) do
    maybe_transact(fn ->
      read!(cve_id)
    end)
  end

  def read!(id), do: maybe_transact(fn -> Query.read(__MODULE__, id) end)
  def read!(id, lock: lock), do: maybe_transact(fn -> Query.read(__MODULE__, id, lock: lock) end)

  def update(cve_id, fields) do
    f = fn ->
      read!(cve_id, lock: :write)
      |> cast(fields)
      |> insert!
    end

    maybe_transact(f)
  end

  def cast(cve \\ %Cve{}, params) do
    struct(cve, params)
  end
end
