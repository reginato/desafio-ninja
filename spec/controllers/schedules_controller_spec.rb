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

  describe "POST create" do
    let(:room) { create(:room) }
    let(:user) { create(:user) }

    context "with valid attributes" do
      it "creates a new schedule" do
        expect{
          post :create, params: { room_id: room.id, user_id: user.id, scheduled_at: "2022-07-21, 9:00 am" }
        }.to change(Schedule, :count).by(1)
      end

      it "don't create a new schedule because out of work hour" do
        expect{
          post :create, params: { room_id: room.id, user_id: user.id, scheduled_at: "2022-07-21, 5:00 am" }
        }.to change(Schedule, :count).by(0)
      end      
    end
  end  

  describe "PUT update" do
    let!(:schedule) { create(:schedule) }
     
    context 'with a valid attributes' do
      it 'update a schedule' do
        put :update, params: { id: schedule.id, scheduled_at: "2022-07-21, 11:00 am" }

        expect(schedule.reload.scheduled_at).to eq("2022-07-21 11:00:00 am")
      end  

      it 'dont update a schedule' do
        put :update, params: { id: schedule.id, scheduled_at: nil }

        expect(schedule.reload.scheduled_at).to eq("2022-07-21 9:00:00 am")
      end  
    end  
  end  

  describe '#destroy' do
    context 'existing post' do
      let!(:schedule) { create(:schedule) }

      it 'removes post from table' do
        expect { delete :destroy, params: { id: schedule.id } }.to change { Schedule.count }.by(-1)
      end
    end
  end    
end  