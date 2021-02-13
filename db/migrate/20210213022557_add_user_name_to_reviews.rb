class AddUserNameToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :username, :string
  end
end
