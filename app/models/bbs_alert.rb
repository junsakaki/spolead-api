class BbsAlert < ApplicationRecord
    attr_accessor :target_comment
    belongs_to :bbs_comment
end
