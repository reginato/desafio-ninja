# frozen_string_literal: true

class Schedule < ApplicationRecord
    belongs_to :room
    belongs_to :user
  
    validates :user_id, :room_id, :scheduled_at, presence: true
  end
  