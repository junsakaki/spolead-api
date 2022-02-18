class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.integer :salon_id
      t.string :name
      t.string :caption
      t.integer :price
      t.timestamps
    end
    add_index :plans, [:name, :caption, :price]
  end
end
