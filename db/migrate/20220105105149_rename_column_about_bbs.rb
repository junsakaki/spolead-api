class RenameColumnAboutBbs < ActiveRecord::Migration[6.0]
  def change
    rename_table :bbs_forums, :forums
    rename_column :bbs_threads, :bbs_forum_id, :forum_id
    rename_table :bbs_threads, :threads
    rename_column :bbs_comments, :bbs_thread_id, :thread_id
    rename_table :bbs_comments, :comments
    rename_column :bbs_reports, :bbs_comment_id, :comment_id
    rename_table :bbs_reports, :reports
  end
end
