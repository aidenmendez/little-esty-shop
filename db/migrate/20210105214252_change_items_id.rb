class ChangeItemsId < ActiveRecord::Migration[5.2]
  def change
    rename_column :invoice_items, :items_id, :item_id
  end
end
