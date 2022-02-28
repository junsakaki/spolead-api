class ChangeTableMatchingsToLessons < ActiveRecord::Migration[6.0]
  def change
    rename_table :matchings, :lessons
    rename_table :matching_owners, :lesson_owners
  end
end
