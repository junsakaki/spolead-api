class ChangeColumnTypeMatchingImages < ActiveRecord::Migration[6.0]
  def up
    change_column :matchings, :image_top, :text, limit: 4294967295
    change_column :matchings, :image_sub, :text, limit: 4294967295
    change_column :matchings, :background, :text, limit: 4294967295
    change_column :matching_owners, :identification_1, :text, limit: 4294967295
    change_column :matching_owners, :identification_2, :text, limit: 4294967295
  end
end
