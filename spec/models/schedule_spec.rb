require 'rails_helper'

RSpec.describe Schedule, type: :model do
	%i[room_id user_id scheduled_at].each do |field|
    it { is_expected.to validate_presence_of field }
  end 
end
