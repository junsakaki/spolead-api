class ChangeColumnTypeFundImages < ActiveRecord::Migration[6.0]
  def up
    change_column :funds, :image_top, :text, limit: 4294967295
    change_column :funds, :image_sub, :text, limit: 4294967295
    change_column :funds, :background, :text, limit: 4294967295
    change_column :fund_owners, :identification_1, :text, limit: 4294967295
    change_column :fund_owners, :identification_2, :text, limit: 4294967295
  end
end
