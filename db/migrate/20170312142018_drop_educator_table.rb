class DropEducatorTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :educators
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
