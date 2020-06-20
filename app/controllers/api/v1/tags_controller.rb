# frozen_string_literal: true

module Api
  module V1
    class TagsController < ApplicationController
      def index
        @tags = Tag.page(params[:page]).order('id asc')
      end

      def create
        @tag = Tag.new(tag_params)
        if @tag.save
          render 'show'
        else
          render_errors
        end

      end

      def update
        @tag = Tag.find(params[:id])
        if @tag.update(tag_params)
          render 'show'
        else
          render_errors
        end
      end

      private

      def tag_params
        params.require(:data).require(:attributes).permit(:title)
      end

      def render_errors
        @errors = @tag.errors
        render 'api/v1/errors/errors', status: :unprocessable_entity
      end
    end
  end
end
