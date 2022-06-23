# frozen_string_literal: true

class ScheduleSearch
    def initialize(schedule_params)
      @room_id = schedule_params[:room_id]
      @user_id = schedule_params[:user_id]
    end 
  
    def search
      if params_search?
        Schedule.where('room_id = ? OR user_id = ?', @room_id, @user_id)
      else
        Schedule.all
      end    
    end  
  
    def params_search?
      @room_id.present? || @user_id.present?
    end  
  end    