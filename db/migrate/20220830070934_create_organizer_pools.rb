class CreateOrganizerPools < ActiveRecord::Migration[6.0]
  def up
    create_table :organizer_pools do |t|
      t.string :content
      t.integer :amount, null: false
      t.integer :organizer_id, null: false
      t.integer :participant_id
      t.integer :subscribable_id
      t.string :subscribable_type
      t.integer :month, null: false
      t.timestamps
    end
    add_index :organizer_pools, [
      :content,
      :amount,
      :organizer_id,
      :participant_id,
      :subscribable_id,
      :subscribable_type,
      :month,
      :created_at,
      :updated_at
    ], :name => 'cover'

  end

  def down
    drop_table :organizer_pools if table_exists?(:organizer_pools)
  end
end
