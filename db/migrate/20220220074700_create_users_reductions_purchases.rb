class CreateUsersReductionsPurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :users_reductions_purchases do |t|
      t.integer :reduction_id
      t.integer :user_id
      t.integer :price
      t.integer :count
      t.timestamps
    end
  end
end
