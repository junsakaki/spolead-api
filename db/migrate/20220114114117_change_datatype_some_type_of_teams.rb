class ChangeDatatypeSomeTypeOfTeams < ActiveRecord::Migration[6.0]
  def up
    change_column :teams, :team_type, :string
    change_column :teams, :target_age_type, :string
  end

  def down
    # change_column :teams, :team_type, :integer
    # change_column :teams, :target_age_type, :integer
  end
end
