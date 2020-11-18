class AddCityCodeToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :CityCode, :integer
  end
end
