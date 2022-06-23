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
    end  
  end
end    