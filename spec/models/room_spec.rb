# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Room, type: :model do
  it { is_expected.to have_many(:schedules) } 
  it { is_expected.to validate_presence_of :name }
end    