defmodule CveSync.Db.Version do
  use Memento.Table,
    attributes: [:cve_id, :product_id, :version],
    index: [:product_id]
end
