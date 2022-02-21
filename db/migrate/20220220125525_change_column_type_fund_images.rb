class ChangeColumnTypeFundImages < ActiveRecord::Migration[6.0]
  def up
    change_column :funds, :image_top, :text
    change_column :funds, :image_sub, :text
    change_column :funds, :background, :text
    change_column :fund_owners, :identification_1, :text
    change_column :fund_owners, :identification_2, :text
  end
end
