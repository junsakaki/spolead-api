class ChangeDatatypeTeamImageOfTeams < ActiveRecord::Migration[6.0]
  def change
    change_column :teams, :team_image, :binary
  end
end
