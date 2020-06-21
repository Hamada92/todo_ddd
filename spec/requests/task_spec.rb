require "rails_helper"

RSpec.describe "Task", :type => :request do
  let(:headers) { { "ACCEPT" => "application/vnd.api+json" } }

  context "create task" do
    it "creates a Task" do
      post "/api/v1/tasks", params: { data: { attributes: {title:  "Test Task"} } }, :headers => headers

      expect(response.content_type).to eq("application/vnd.api+json")
      expect(response).to have_http_status(:created)
      expect(response).to render_template(:show)
      expect(JSON.parse(response.body).dig("data", "attributes", "title")).to eq("Test Task")
    end
  end

  context "update task" do
    let(:task) { create(:task) }

    it "updates a Task" do
      patch "/api/v1/tasks/#{task.id}", params: { data: { attributes: {title:  "New Test Task"} } }, :headers => headers

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(task.reload.title).to eq("New Test Task")
      expect(JSON.parse(response.body).dig("data", "attributes", "title")).to eq("New Test Task")
    end

    context "with empty title" do
      it "returns an error" do
        patch "/api/v1/tasks/#{task.id}", params: { data: { attributes: {title:  ""} } }, :headers => headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:errors)
        expect(JSON.parse(response.body)["errors"][0]["detail"][0]).to include("title is required")

      end
    end

    context "with tags" do
      it "updates the task and assigns the tags" do
        patch "/api/v1/tasks/#{task.id}", params: { data: { attributes: {title:  "Test Task", tags: ["Today", "Tomorrow"]} } }, :headers => headers

        expect(response).to have_http_status(:ok)
        expect(task.tags.map(&:title)).to eq(["Today", "Tomorrow"])
      end
    end
  end

  context "destroy task" do
    let(:task) { create(:task) }

    context "task exists" do
      it "destroys the task and returns :no_content status" do
        delete "/api/v1/tasks/#{task.id}", :headers => headers

        expect(response).to have_http_status(:no_content)
      end
    end

    context "task does not exist" do
      it "returns :not_found status" do
        delete "/api/v1/tasks/123456", :headers => headers

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
