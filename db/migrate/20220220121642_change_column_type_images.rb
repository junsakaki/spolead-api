class ChangeColumnTypeImages < ActiveRecord::Migration[6.0]
  def up
    change_column :salons, :image_top, :text, limit: 4294967295
    change_column :salons, :image_sub, :text, limit: 4294967295
    change_column :salons, :background, :text, limit: 4294967295
    change_column :salon_owners, :identification_1, :text, limit: 4294967295
    change_column :salon_owners, :identification_2, :text, limit: 4294967295
  end
end
