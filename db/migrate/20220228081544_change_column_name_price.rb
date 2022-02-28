class ChangeColumnNamePrice < ActiveRecord::Migration[6.0]
  def change
    rename_column :reductions, :price, :amount
    rename_column :lessons_talk_rooms, :matching_id, :lesson_id
    rename_column :matching_owners, :matching_id, :lesson_id
  end
end
