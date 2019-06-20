defmodule CveSync.Db.Cve do
  use Memento.Table,
    attributes: [:id, :assigner, :description, :last_modified_date, :published_date]
end
