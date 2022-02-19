class AddColumnApprovalToSalons < ActiveRecord::Migration[6.0]
  def change
    add_column :salons, :approval, :boolean, default: false
  end
end
