class ChangeDatatypeSomeTypeOfTeams < ActiveRecord::Migration[6.0]
  def up
    change_column :teams, :team_type, :string
    change_column :teams, :target_age_type, :string
    change_column :teams, :city_code, :string
    rename_column :teams, :city_code, :city_codes
  end

  def down
    change_column :teams, :team_type, :integer
    change_column :teams, :target_age_type, :integer
    rename_column :teams, :city_codes, :city_code
    change_column :teams, :city_code, :integer
  end
end
