class ChangeColumnTypeMatchingImages < ActiveRecord::Migration[6.0]
  def up
    change_column :matchings, :image_top, :text
    change_column :matchings, :image_sub, :text
    change_column :matchings, :background, :text
    change_column :matching_owners, :identification_1, :text
    change_column :matching_owners, :identification_2, :text
  end
end
