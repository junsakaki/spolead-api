class AddColumnReplyTo < ActiveRecord::Migration[6.0]
  def change
    add_column :bbs_comments, :reply_to, :integer
  end
end
