class RenameTeamInfomationToTeamInformation < ActiveRecord::Migration[6.0]
  def change
    rename_column :teams, :team_infomation, :team_information
  end
end
