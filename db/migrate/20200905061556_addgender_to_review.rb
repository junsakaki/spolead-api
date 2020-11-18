class AddgenderToReview < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :gender, :integer
    add_column :reviews, :age_group, :integer
    add_column :reviews, :enrollment_period, :string
    add_column :reviews, :player_flag, :integer
  end
end
