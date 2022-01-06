class AddColumnSportsId < ActiveRecord::Migration[6.0]
  def change
    add_column :bbs_forums, :sports_id, :integer
  end
end
