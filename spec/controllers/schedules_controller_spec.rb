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

  describe 'GET #show' do
    context 'when schedule is found' do
      let(:schedule) { create(:schedule) }

      it 'response data with right receivable' do
        get :show, params: { id: schedule }

        expect(JSON.parse(response.body)["status"]).to eq("SUCCESS")
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when schedule is not found' do
      it do
        expect {
          get :show, params: { id: 9999 }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end  
    end
  end
end  