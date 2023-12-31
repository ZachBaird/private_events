class AttendingEvent < ApplicationRecord
  belongs_to :attended_event, class_name: 'Event', foreign_key: :event_id
  belongs_to :attending_user, class_name: 'User', foreign_key: :user_id
end
