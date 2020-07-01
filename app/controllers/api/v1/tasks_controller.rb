# frozen_string_literal: true
require 'securerandom'

module Api
  module V1
    class TasksController < ApplicationController
      def index
        @task_views = ::Views::TaskWithAssociatedTag.page(params[:page]).order('id asc')
      end

      def create
        cmd = Tasks::SubmitTaskCommand.new(
          title: task_attributes[:title],
          aggregate_id: new_aggregate_id)

        TasksService.new.call(cmd)
        @task_view = ::Views::TaskWithAssociatedTag.find_by(aggregate_id: cmd.aggregate_id)
        render 'show', status: :created

      rescue Command::ValidationError
        @errors = cmd.errors
        render 'api/v1/errors/errors', status: :unprocessable_entity
      end

      def update
        task = TaskRecord::Task.find(params[:id])
        cmd = Tasks::UpdateTaskCommand.new(
          title: task_attributes[:title],
          tags: task_attributes[:tags],
          aggregate_id: task.aggregate_id)

        TasksService.new.call(cmd)
        @task_view = ::Views::TaskWithAssociatedTag.find_by(aggregate_id: cmd.aggregate_id)
        render 'show'

      rescue Command::ValidationError
        @errors = cmd.errors
        render 'api/v1/errors/errors', status: :unprocessable_entity
      end

      def destroy
        task = TaskRecord::Task.find_by(id: params[:id])

        if task.blank? || task.deleted_at?
          head :not_found
          return
        end

        cmd = Tasks::DeleteTaskCommand.new(
          aggregate_id: task.aggregate_id)
        TasksService.new.call(cmd)

        head :no_content
      end

      private

      def task_params
        params.require(:data).permit(:type, attributes: [:title, tags: [] ] )
      end

      def task_attributes
        task_params[:attributes]
      end
    end
  end
end
