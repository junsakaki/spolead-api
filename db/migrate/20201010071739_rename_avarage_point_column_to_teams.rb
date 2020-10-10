class RenameAvaragePointColumnToTeams < ActiveRecord::Migration[6.0]
  def change
    rename_column :teams, :avarage_point, :average_point
  end
end
