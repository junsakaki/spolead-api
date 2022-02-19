class CreateFunds < ActiveRecord::Migration[6.0]
  def change
    create_table :funds do |t|
      t.string :name
      t.string :caption
      t.binary :image_top
      t.binary :image_sub
      t.string :content
      t.binary :background
      t.string :self_introduction
      t.string :precautions
      t.integer :target_money
      t.date :limit_date
      t.timestamps
    end
    add_index :funds, [:name, :caption, :content, :precautions, :target_money, :limit_date], name: 'cover_funds_index'
  end
end
