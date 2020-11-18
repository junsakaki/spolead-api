class AddCityToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :city, :string
  end
end
