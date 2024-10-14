defmodule CveSync.Db do
  alias Memento.Query
  alias CveSync.Db.{Cve, Product, Version, Vendor}

  def maybe_transact(f) do
    case Memento.Transaction.inside?() do
      false ->
        Memento.transaction(f)

      _ ->
        f.()
    end
  end
end
