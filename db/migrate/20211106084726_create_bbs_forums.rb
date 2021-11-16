class CreateBbsForums < ActiveRecord::Migration[6.0]
  def change
    create_table :bbs_forums do |t|
      t.string :name
      t.string :user_name
      t.string :content

      t.timestamps
    end
    add_index :bbs_forums, :content
  end
end
