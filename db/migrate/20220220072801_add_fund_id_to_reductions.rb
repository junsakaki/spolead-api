class AddFundIdToReductions < ActiveRecord::Migration[6.0]
  def change
    add_column :reductions, :fund_id, :integer
  end
end
