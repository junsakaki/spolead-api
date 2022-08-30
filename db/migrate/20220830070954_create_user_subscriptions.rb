class CreateUserSubscriptions < ActiveRecord::Migration[6.0]
  def up
    create_table :user_subscriptions do |t|
      t.string :content
      t.integer :amount, null: false
      t.integer :user_id, null: false
      t.integer :subscribable_id
      t.string :subscribable_type
      t.integer :month, null: false
      t.timestamps
    end
    add_index :user_subscriptions, [
      :content,
      :amount,
      :user_id,
      :subscribable_id,
      :subscribable_type,
      :month,
      :created_at,
      :updated_at
    ], :name => 'cover'

  end

  def down
    drop_table :user_subscriptions if table_exists?(:user_subscriptions)
  end
end
