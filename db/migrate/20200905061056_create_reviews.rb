class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.text :general_post
      t.integer :general_point
      t.text :policy_post
      t.integer :policy_point
      t.text :organization_post
      t.integer :organization_point
      t.text :activity_post
      t.integer :activity_point
      t.text :environment_post
      t.integer :environment_point
      t.text :event_post
      t.integer :event_point
      t.text :cost_post
      t.integer :cost_point
      t.integer :team_id
      t.integer :user_id

      t.timestamps
    end
  end
end
