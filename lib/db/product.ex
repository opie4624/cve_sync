defmodule CveSync.Db.Product do
  use Memento.Table,
    attributes: [:id, :vendor_id, :name],
    index: [:vendor_id],
    autoincrement: true
end
