require "rails_helper"

RSpec.describe "Tag", :type => :request do
  let(:headers) { { "ACCEPT" => "application/vnd.api+json" } }

  context "create tag" do
    it "creates a Tag" do
      post "/api/v1/tags", params: { data: { attributes: {title:  "Test Tag"} } }, :headers => headers

      expect(response.content_type).to eq("application/vnd.api+json")
      expect(response).to have_http_status(:created)
      expect(response).to render_template(:show)
      expect(JSON.parse(response.body)["data"]["attributes"]["title"]).to eq("Test Tag")
    end
  end

  context "update task" do
    let(:tag) { create(:tag) }

    it "updates a Tag" do
      patch "/api/v1/tags/#{tag.id}", params: { data: { attributes: {title:  "New Test Tag"} } }, :headers => headers

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(tag.reload.title).to eq("New Test Tag")
      expect(JSON.parse(response.body)["data"]["attributes"]["title"]).to eq("New Test Tag")
    end

    context "with empty title" do
      it "returns an error" do
        patch "/api/v1/tags/#{tag.id}", params: { data: { attributes: {title:  ""} } }, :headers => headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:errors)
        expect(JSON.parse(response.body)["errors"][0]["detail"][0]).to include("title is required")
      end
    end
  end
end
