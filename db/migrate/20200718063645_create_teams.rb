class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :email
      t.integer :sports_id
      t.string :address
      t.integer :team_type
      t.integer :target_age_type
      t.string :team_infomation

      t.timestamps
    end
  end
end
