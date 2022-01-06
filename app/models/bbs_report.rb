class BbsReport < ApplicationRecord
    self.table_name = "reports"
    attr_accessor :target_comment
    belongs_to :comment
end
