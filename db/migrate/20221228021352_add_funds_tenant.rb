class AddFundsTenant < ActiveRecord::Migration[6.0]
  def change
    add_column :funds, :payjp_tenant, :string
  end
end
