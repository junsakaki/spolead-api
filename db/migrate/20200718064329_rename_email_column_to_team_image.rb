class RenameEmailColumnToTeamImage < ActiveRecord::Migration[6.0]
  def change
    rename_column :teams, :email, :team_image
  end
end
