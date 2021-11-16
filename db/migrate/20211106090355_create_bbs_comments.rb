class CreateBbsComments < ActiveRecord::Migration[6.0]
  def change
    create_table :bbs_comments do |t|
      t.string :user_name
      t.integer :bbs_thread_id
      t.string :content

      t.timestamps
    end
    add_index :bbs_comments, :content
  end
end
