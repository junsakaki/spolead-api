class CreateLessonComments < ActiveRecord::Migration[6.0]
  def change
    create_table :lesson_comments do |t|
      t.integer :user_id
      t.integer :talk_id
      t.text :content
      t.timestamps
    end
  end
end
