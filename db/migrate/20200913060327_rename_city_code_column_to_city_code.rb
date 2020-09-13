class RenameCityCodeColumnToCityCode < ActiveRecord::Migration[6.0]
  def change
    rename_column :teams, :CityCode, :city_code
  end
end
