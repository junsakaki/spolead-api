class CreateBbsComments < ActiveRecord::Migration[6.0]
  def change
    create_table :bbs_comments do |t|
      t.string :user_name
      t.integer :bbs_thread_id
      t.text :content

      t.timestamps
    end
  end
end
