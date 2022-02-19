class CreateReductions < ActiveRecord::Migration[6.0]
  def change
    create_table :reductions do |t|
      t.string :name
      t.string :caption
      t.integer :price
      t.timestamps
    end
  end
end
