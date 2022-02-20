class ChangeColumnTypeOwners < ActiveRecord::Migration[6.0]
  def change
    change_column :salon_owners, :tel, :string
    change_column :fund_owners, :tel, :string
    change_column :matching_owners, :tel, :string
  end
end
