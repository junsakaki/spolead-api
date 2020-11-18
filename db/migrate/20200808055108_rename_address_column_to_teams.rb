class RenameAddressColumnToTeams < ActiveRecord::Migration[6.0]
  def change
    rename_column :teams, :address, :mail_address
  end
end
