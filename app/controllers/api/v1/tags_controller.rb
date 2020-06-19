module Api
  module V1
    class TagsController < ApplicationController
      def index
        @tags = Tag.page(params[:page]).order("id asc")
      end

      def create
        @tag = Tag.where(tag_params).first_or_create!
        render 'show'
      end

      def update
        @tag = Tag.find(params[:id])
        if @tag.update(tag_params)
          render 'show'
        else
          @errors = @tag.errors
          render 'api/v1/errors/errors', status: :unprocessable_entity
        end
      end

      private

      def tag_params
        params.require(:data).require(:attributes).permit(:title)
      end
    end
  end
end
