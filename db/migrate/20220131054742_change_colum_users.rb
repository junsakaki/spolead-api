class ChangeColumUsers < ActiveRecord::Migration[6.0]
  def change
      change_column_null :users, :email, true
      change_column_null :users, :encrypted_password, true
      add_column :users, :social_login_id, :string
      remove_index :users, :email if index_exists?(:users, :email)
  end
end
