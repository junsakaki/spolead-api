class RenameColumnPriceToAmount < ActiveRecord::Migration[6.0]
  def change
    rename_column :plans, :price, :amount
  end
end
