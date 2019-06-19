defmodule CveSync.Db.CveProduct do
  use Memento.Table,
    attributes: [:cve_id, :product_id],
    index: [:product_id]
end
