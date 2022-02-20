class ChangeColumnTypeMatchingImages < ActiveRecord::Migration[6.0]
  def change
    change_column :matchings, :image_top, :string
    change_column :matchings, :image_sub, :string
    change_column :matchings, :background, :string
    change_column :matching_owners, :identification_1, :string
    change_column :matching_owners, :identification_2, :string
  end
end
