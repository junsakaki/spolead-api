class ChangeColumnReqruitmentTarget < ActiveRecord::Migration[6.0]
  def change
    rename_column :lessons, :reqruitment_target, :recruitment_target
  end
end
