class ChangeColumnTypeImages < ActiveRecord::Migration[6.0]
  def change
    change_column :salons, :image_top, :string
    change_column :salons, :image_sub, :string
    change_column :salons, :background, :string
    change_column :salon_owners, :identification_1, :string
    change_column :salon_owners, :identification_2, :string
  end
end
