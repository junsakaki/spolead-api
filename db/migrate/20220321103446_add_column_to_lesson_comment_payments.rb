class AddColumnToLessonCommentPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :lesson_comment_payments, :plan_id, :string
    add_column :lesson_comment_payments, :payment_id, :string
  end
end
