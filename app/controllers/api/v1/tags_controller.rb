module Api
  module V1
    class TagsController < ApplicationController
      def index
        @tags = Tag.order("id asc")
      end

      def create
        @tag = Tag.where(tag_params).first_or_create!
        render 'show'
      end

      def update
        @tag = Tag.find(params[:id])
        @tag.update!(tag_params)
        render 'show'
      end

      private

      def tag_params
        params.require(:data).require(:attributes).permit(:title)
      end
    end
  end
end
