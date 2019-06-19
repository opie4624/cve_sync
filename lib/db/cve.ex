defmodule CveSync.Db.Cve do
  use Memento.Table,
    attributes: [:id, :description, :last_modified_date, :published_date]
end
