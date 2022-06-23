# frozen_string_literal: true

module Api
  module V1
    class SchedulesController < ApplicationController
      def index
        @schedules = ScheduleSearch.new(schedule_params).search 

        render json: { status: 'SUCCESS', message: 'Schedule list.', data: @schedules }, status: :ok 
      end

      def show
        schedule = Schedule.find(params[:id])

        render json: { status: 'SUCCESS', message: 'Schedule founded.', data: schedule }, status: :ok
      end

      def create
        schedule = Schedule.new(schedule_params)
        
        if valid_time? && schedule.save
          render json: { status: 'SUCCESS', message: 'Schedule added.', data: schedule }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Can not add the Schedule.', data: schedule.errors }, status: :unprocessable_entity
        end
      end


      def update
        schedule = Schedule.find(params[:id])

        if valid_time? && schedule.update(schedule_params)
          render json: { status: 'SUCCESS', message: 'Schedule updated.', data: schedule }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Can not update Schedule', data: schedule }, status: :unprocessable_entity
        end
      end
  
      def destroy
        schedule = Schedule.find(params[:id])

        schedule.destroy
        render json: { status: 'SUCCESS', message: 'Schedule deleted.', data: schedule }, status: :ok
      end
      
      private  
      
      def valid_time?
        return if params[:scheduled_at].blank?

        Time.parse(params[:scheduled_at]).during_business_hours?
      end

      def schedule_params
        params.permit(:room_id, :user_id, :scheduled_at, :id)
      end
    end  
  end
end    