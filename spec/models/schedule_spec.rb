# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Schedule, type: :model do
	%i[room_id user_id scheduled_at].each do |field|
    it { is_expected.to validate_presence_of field }
  end 

  describe "validates" do
    let!(:user) { create(:user) }
    let!(:room) { create(:room) }
    let(:schedule) { build :schedule, room: room, user: user, scheduled_at: "2022-07-21, 9:00 am" }
    let(:schedule_2) { build :schedule, room: room, user: user, scheduled_at: "2022-06-20, 9:00 am" }
  
    context "valid future date" do
      it { expect(schedule).to be_valid }
    end

    context "invalid pass date" do
      it { expect(schedule_2).to_not be_valid }
    end
  end  
end
