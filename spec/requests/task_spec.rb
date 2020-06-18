require "rails_helper"

RSpec.describe "Task", :type => :request do

  it "creates a Task" do
    headers = { "ACCEPT" => "application/json" }
    post "/api/v1/tasks", params: { data: { attributes: {title:  "Test Task"} } }, :headers => headers

    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:created)
  end

  context "Task Update" do
    let(:task) { create(:task) }

    it "updates a Task" do
      headers = { "ACCEPT" => "application/json" }
      patch "/api/v1/tasks/#{task.id}", params: { data: { attributes: {title:  "Test Task"} } }, :headers => headers

      expect(response).to have_http_status(:ok)
      expect(task.reload.title).to eq("Test Task")
    end

    context "with empty title" do
      it "returns an error" do
        headers = { "ACCEPT" => "application/json" }
        patch "/api/v1/tasks/#{task.id}", params: { data: { attributes: {title:  ""} } }, :headers => headers

        expect(response).to have_http_status(:bad_request)
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
end
