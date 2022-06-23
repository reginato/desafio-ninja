# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SchedulesController, type: :controller do
  describe 'GET #index' do
    context 'when params is right' do

      it 'return all schedules'do
        get :index

        expect(response).to have_http_status(:ok)
      end    
    end
  end 
end  