class AddColumnToPayment < ActiveRecord::Migration[6.0]
  def change
    add_column :lesson_comment_payments, :cancel, :boolean, default: false
  end
end
