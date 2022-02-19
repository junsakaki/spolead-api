class CreateFundOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :fund_owners do |t|
      t.integer :fund_id
      t.integer :user_id
      t.string :name
      t.string :address
      t.string :mail_address
      t.string :birthday
      t.integer :tel
      t.binary :identification_1
      t.binary :identification_2
      t.string :transfer_account
      t.timestamps
    end
    add_index :fund_owners, [:name, :address, :mail_address]
  end
end
