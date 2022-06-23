# frozen_string_literal: true

module Api
  module V1
    class SchedulesController < ApplicationController
      def index
        @schedules = Schedule.all

        render json: { data: @schedules }, status: :ok 
      end

      def show
        schedule = Schedule.find(params[:id])

        render json: { status: 'SUCCESS', message: 'Schedule founded.', data: schedule }, status: :ok
      end

      def create
        schedule = Schedule.new(schedule_params)
        
        if schedule.save
          render json: { status: 'SUCCESS', message: 'Schedule added.', data: schedule }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Can not add the Schedule.', data: schedule.errors }, status: :unprocessable_entity
        end
      end

      def schedule_params
        params.permit(:room_id, :user_id, :scheduled_at, :id)
      end
    end  
  end
end    