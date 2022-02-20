class AddColumnApprovalToFunds < ActiveRecord::Migration[6.0]
  def change
    add_column :funds, :approval, :boolean, default: false
  end
end
