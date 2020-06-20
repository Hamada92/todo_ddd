# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      def index
        @task_views = ::Views::TaskWithAssociatedTag.page(params[:page]).order('id asc')
      end

      def create
        @task = Task.new(task_params)
        if @task.save
          @task_view = ::Views::TaskWithAssociatedTag.find(@task.id)
          render 'show', status: :created
        else
          @errors = @task.errors
          render 'api/v1/errors/errors', status: :unprocessable_entity
        end
      end

      def update
        service = ::TaskTagsService.new(params[:id], task_params)
        service.call

        if service.errors.present?
          @errors = service.errors
          render 'api/v1/errors/errors', status: :unprocessable_entity
          return
        end

        @task_view = ::Views::TaskWithAssociatedTag.find(params[:id])
        render 'show'
      end

      def destroy
        @task = Task.find_by(id: params[:id])
        # https://jsonapi.org/format/#crud-deleting-responses-404
        if @task.blank?
          head :not_found
          return
        end

        @task.destroy
        head :no_content
      end

      private

      def task_params
        params.require(:data).require(:attributes).permit(:title, tags: [])
      end

      def tags
        task_params[:tags]
      end
    end
  end
end
