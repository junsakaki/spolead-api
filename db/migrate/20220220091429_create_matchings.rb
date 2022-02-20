class CreateMatchings < ActiveRecord::Migration[6.0]
  def change
    create_table :matchings do |t|
      t.string :name
      t.string :caption
      t.binary :image_top
      t.binary :image_sub
      t.string :content
      t.binary :background
      t.string :self_introduction
      t.string :precautions
      t.boolean :approval, default: false
      t.timestamps
    end
    add_index :matchings, [:name, :caption, :content, :precautions], name: 'cover_matchings_index'
  end
end
