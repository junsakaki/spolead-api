class AddColumnsToMatchings < ActiveRecord::Migration[6.0]
  def change
    add_column :matchings, :reqruitment_target, :string
    add_column :matchings, :contact_type, :string
    add_column :matchings, :payment_type, :string
  end
end
