class ChangeDataTeamImageToTeams < ActiveRecord::Migration[6.0]
  def change
    change_column :teams, :team_image, :binary, :limit => 5.megabyte
  end
end
