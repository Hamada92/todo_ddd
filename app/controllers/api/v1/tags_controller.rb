# frozen_string_literal: true

module Api
  module V1
    class TagsController < ApplicationController
      def index
        @tags = TagRecord::Tag.page(params[:page]).order('id asc')
      end

      def create
        @tag = TagRecord::Tag.new(tag_attributes)
        if @tag.save
          render 'show', status: :created
        else
          render_errors
        end
      end

      def update
        @tag = TagRecord::Tag.find(params[:id])
        if @tag.update(tag_attributes)
          render 'show'
        else
          render_errors
        end
      end

      private

      def tag_params
        params.require(:data).permit(attributes: [:title])
      end

      def tag_attributes
        tag_params[:attributes]
      end

      def render_errors
        @errors = @tag.errors
        render 'api/v1/errors/errors', status: :unprocessable_entity
      end
    end
  end
end
