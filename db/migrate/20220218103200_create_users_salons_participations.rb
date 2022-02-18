class CreateUsersSalonsParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :users_salons_participations do |t|
      t.integer :user_id
      t.integer :salon_id
      t.timestamps
    end
    add_index :users_salons_participations, [:user_id, :salon_id]
  end
end
