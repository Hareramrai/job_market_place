# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Api::V1::UsersController", type: :request, swagger_doc: SWAGGER_V1_DOC do
  include_context "sample jobs"

  let!(:user) { create(:user) }
  let(:Authorization) { authenticate_headers(user)["Authorization"] }

  path "/jobs/" do
    post "Create a job with shifts" do
      tags "Jobs API"

      consumes MIME_APPLICATION_JSON
      security [jwt: []]

      parameter in: :body, name: :params, schema: { "$ref" => "#/components/schemas/new_job" }

      response "200", "Created a user" do
        let(:shift) { build(:shift) }
        let(:job) {  attributes_for(:job, shifts_attributes: [shift]) }
        let(:params) { { job: job } }

        schema type: :object, properties: { "$ref" => "#/components/schemas/job" }

        run_test! do
          last_addded_job = Job.last
          expect(Job.find_by(title: job[:title])).to eq(last_addded_job)
        end
      end

      response "422", "Validation failed for request" do
        let(:shift) { build(:shift) }
        let(:job) {  attributes_for(:job, language_list: "", shifts_attributes: [shift]) }
        let(:params) { { job: job } }

        schema type: :object, properties: { "$ref" => "#/components/schemas/errors_object" }

        run_test!
      end
    end

    get "List of jobs with filters" do
      tags "Jobs API"

      consumes MIME_APPLICATION_JSON
      security [jwt: []]

      parameter name: :title, in: :query, type: :string
      parameter name: :language, in: :query, type: :string

      response "200", "returns the filtered jobs when passing search query" do
        let(:language) { "german" }
        let(:title) { "software" }

        schema \
          type: :object,
          properties: {
            data: {
              type: :array,
              items: { "$ref" => "#/components/schemas/job" },
            },
          }

        run_test! do
          expect(json_response(response).dig(:jobs, 0, :languages)).to eq(["german"])
          expect(json_response(response).dig(:jobs, 0, :title)).to include("software")
        end
      end
    end
  end
end
