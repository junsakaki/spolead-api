class ChangeOwnerToSalonOwner < ActiveRecord::Migration[6.0]
  def change
    rename_table :owners, :salon_owners
  end
end
