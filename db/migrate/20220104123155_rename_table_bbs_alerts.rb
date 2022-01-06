class RenameTableBbsAlerts < ActiveRecord::Migration[6.0]
  def change
    rename_table :bbs_alerts, :bbs_reports
  end
end
