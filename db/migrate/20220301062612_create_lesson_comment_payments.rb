class CreateLessonCommentPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :lesson_comment_payments do |t|
      t.integer :lesson_comment_id
      t.integer :amount
      t.boolean :paid, default: false
      t.timestamps
    end
  end
end
