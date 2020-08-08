class AddPrefectureToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :prefecture, :string
  end
end
