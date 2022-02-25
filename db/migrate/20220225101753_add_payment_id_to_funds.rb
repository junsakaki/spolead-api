class AddPaymentIdToFunds < ActiveRecord::Migration[6.0]
  def change
    add_column :users_reductions_purchases, :payment_id, :string
  end
end
