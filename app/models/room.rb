# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :schedules  
  
  validates :name, presence: true
end
  