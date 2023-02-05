class AddColomnSalonTenantCustmer < ActiveRecord::Migration[6.0]
  def change
    add_column :plans, :payjp_tenant, :string
    add_column :users_salons_participations, :customer_id, :string
  end
end
