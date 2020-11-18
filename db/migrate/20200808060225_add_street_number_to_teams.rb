class AddStreetNumberToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :street_number, :string
  end
end
