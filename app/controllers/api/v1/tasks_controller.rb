module Api
  module V1
    class TasksController < ApplicationController
      def index
        @task_views = ::Views::TaskWithAssociatedTag.order("id asc")
      end

      def create
        @task = Task.new(task_params)
        if @task.save
          @task_view = ::Views::TaskWithAssociatedTag.find(@task.id)
          render 'show', status: :created
        else
          render 'errors', errors: @task.errors, status: :bad_request
        end

      end

      def update
        @task = Task.find(params[:id])
        @task.assign_attributes(task_params.except(:tags))

        unless @task.valid?
          @errors = @task.errors
          render 'errors', status: :bad_request
          return
        end

        # Use transaction to guarantee Atomicity of tasks and tags
        ActiveRecord::Base.transaction do
          @task.save!
          ::TaskTagsService.new(@task.id, tags).call
        end

        @task_view = ::Views::TaskWithAssociatedTag.find(@task.id)
        render 'show'
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
