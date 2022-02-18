class CreateOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :owners do |t|
      t.integer :salon_id
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
    add_index :owners, [:name, :address, :mail_address]
  end
end
