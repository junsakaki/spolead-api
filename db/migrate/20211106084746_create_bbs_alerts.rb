class CreateBbsAlerts < ActiveRecord::Migration[6.0]
  def change
    create_table :bbs_alerts do |t|
      t.string :user_name
      t.integer :bbs_comment_id
      t.string :content

      t.timestamps
    end
  end
end
