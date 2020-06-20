require "rails_helper"

RSpec.describe "Task", :type => :request do

  context "create task" do
    it "creates a Task" do
      headers = { "ACCEPT" => "application/json" }
      post "/api/v1/tasks", params: { data: { attributes: {title:  "Test Task"} } }, :headers => headers

      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:created)
      expect(response).to render_template(:show)
    end
  end

  context "update task" do
    let(:task) { create(:task) }

    it "updates a Task" do
      headers = { "ACCEPT" => "application/json" }
      patch "/api/v1/tasks/#{task.id}", params: { data: { attributes: {title:  "Test Task"} } }, :headers => headers

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(task.reload.title).to eq("Test Task")
    end

    context "with empty title" do
      it "returns an error" do
        headers = { "ACCEPT" => "application/json" }
        patch "/api/v1/tasks/#{task.id}", params: { data: { attributes: {title:  ""} } }, :headers => headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:errors)
      end
    end

    context "with tags" do
      it "updates the task and assigns the tags" do
        headers = { "ACCEPT" => "application/json" }
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
        headers = { "ACCEPT" => "application/json" }
        delete "/api/v1/tasks/#{task.id}", :headers => headers

        expect(response).to have_http_status(:no_content)
      end
    end

    context "task does not exist" do
      it "returns :not_found status" do
        headers = { "ACCEPT" => "application/json" }
        delete "/api/v1/tasks/123456", :headers => headers

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
