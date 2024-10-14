defmodule CveSync.Db.Vendor do
  use Memento.Table,
    attributes: [:id, :name],
    autoincrement: true
end
