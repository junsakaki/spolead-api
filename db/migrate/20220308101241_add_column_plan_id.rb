class AddColumnPlanId < ActiveRecord::Migration[6.0]
  def change
    add_column :plans, :plan_id, :string
  end
end
