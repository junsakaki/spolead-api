class CreateSalons < ActiveRecord::Migration[6.0]
  def change
    create_table :salons do |t|
      t.string :name
      t.string :caption
      t.binary :image_top
      t.binary :image_sub
      t.string :content
      t.binary :background
      t.string :self_introduction
      t.string :precautions
      t.timestamps
    end
    add_index :salons, [:name, :caption, :content, :precautions]
  end
end
