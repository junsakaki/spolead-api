class ChangeColumnTypeFundImages < ActiveRecord::Migration[6.0]
  def change
    change_column :funds, :image_top, :string
    change_column :funds, :image_sub, :string
    change_column :funds, :background, :string
    change_column :fund_owners, :identification_1, :string
    change_column :fund_owners, :identification_2, :string
  end
end
