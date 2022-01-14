class CreateCareers < ActiveRecord::Migration[6.0]
  def change
    create_table :careers do |t|
      t.string :content
      t.integer :team_id
      t.timestamps
    end
  end
end
