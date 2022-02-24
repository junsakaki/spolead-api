class CreateLessonsTalkRoomsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons_talk_rooms do |t|
      t.integer :matching_id
      t.integer :user_id
      t.timestamps
    end
  end
end
