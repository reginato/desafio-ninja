# frozen_string_literal: true

class Schedule < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :user_id, :room_id, :scheduled_at, presence: true
  validate :future_events

  def future_events
    return if scheduled_at.blank?

    errors.add(:scheduled_at, "Can't be in the past!") if scheduled_at < Time.now
  end
end
