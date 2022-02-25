class ChangePriceToAmount < ActiveRecord::Migration[6.0]
  def change
    rename_column  :users_reductions_purchases, :price, :amount
  end
end
