class AddPrefectureCodeToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :prefecture_code, :integer, after: :prefecture
  end
end
