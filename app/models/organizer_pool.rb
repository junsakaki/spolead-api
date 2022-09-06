class OrganizerPool < ApplicationRecord
    belongs_to :organizer, :foreign_key => 'organizer_id', :class_name => 'User', optional: true
    belongs_to :participant, :foreign_key => 'participant_id', :class_name => 'User', optional: true
end
