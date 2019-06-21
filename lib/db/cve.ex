defmodule CveSync.Db.Cve do
  use Memento.Table,
    attributes: [:id, :assigner, :description, :last_modified_date, :published_date]

  alias __MODULE__

  def insert(cve = %Cve{}) do
    Memento.transaction(fn ->
      Memento.Query.write(cve)
    end)
  end

  def insert(cve) when is_list(cve) do
    Memento.transaction(fn ->
      Enum.map(cve, &insert!(&1))
    end)
  end

  defp insert!(cve = %Cve{}) do
    Memento.Query.write(cve)
  end

  def cast(%{
        id: id,
        assigner: assigner,
        description: description,
        last_modified_date: last_modified_date,
        published_date: published_date
      }) do
    %Cve{
      id: id,
      assigner: assigner,
      description: description,
      last_modified_date: last_modified_date,
      published_date: published_date
    }
  end
end
