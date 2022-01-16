class AddColumnToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :latitude, :float
    add_column :teams, :longitude, :float
    add_column :teams, :url, :string
  end
end
