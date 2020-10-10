class AddAvaragePointToTeam < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :avarage_point, :integer
  end
end
