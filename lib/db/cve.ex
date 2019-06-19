defmodule CveSync.Db.Cve do
  use Memento.Table,
    attributes: [:id, :product_id, :description, :last_modified_date, :published_date],
    index: [:product_id]
end
