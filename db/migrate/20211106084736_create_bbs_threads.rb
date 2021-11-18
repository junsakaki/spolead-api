class CreateBbsThreads < ActiveRecord::Migration[6.0]
  def change
    create_table :bbs_threads do |t|
      t.string :name
      t.string :user_name
      t.integer :bbs_forum_id
      t.string :content
      t.integer :views, default: 0

      t.timestamps
    end
    add_index :bbs_threads, [:content, :name]
  end
end
