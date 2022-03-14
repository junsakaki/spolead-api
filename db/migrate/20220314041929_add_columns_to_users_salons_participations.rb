class AddColumnsToUsersSalonsParticipations < ActiveRecord::Migration[6.0]
  def change
    add_column :users_salons_participations, :payment_id, :string
    add_column :users_salons_participations, :amount, :integer
    add_column :users_salons_participations, :plan_id, :integer
    add_column :users_salons_participations, :count, :integer
  end
end
