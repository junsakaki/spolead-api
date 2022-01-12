class BbsReport < ApplicationRecord
    self.table_name = "reports"
    attr_accessor :target_comment
    belongs_to :bbs_comment, :foreign_key => 'comment_id'
end
