class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :attending_events, through: :attending_events

  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true

  scope :past_events, ->(now) { where('date < ?', now) }
  scope :current_events, ->(now) { where('date >= ?', now) }
end
