class ChangeColumnTypeImages < ActiveRecord::Migration[6.0]
  def up
    change_column :salons, :image_top, :text
    change_column :salons, :image_sub, :text
    change_column :salons, :background, :text
    change_column :salon_owners, :identification_1, :text
    change_column :salon_owners, :identification_2, :text
  end
end
