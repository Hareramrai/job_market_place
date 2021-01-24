# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Api::V1::JobApplicationsController", type: :request, swagger_doc: SWAGGER_V1_DOC do
  include_context "sample jobs"
  let!(:user) { create(:user) }
  let(:Authorization) { authenticate_headers(user)["Authorization"] }
  let(:job_application) { { job_id: english_job.id } }
  let(:params) { { job_application: job_application } }

  path "/job_applications/" do
    post "Create a job application" do
      tags "Job Applications API"

      consumes MIME_APPLICATION_JSON
      security [jwt: []]

      parameter in: :body, name: :params, schema: { "$ref" => "#/components/schemas/new_job_application" }

      response "200", "Created a job application" do
        schema type: :object

        run_test! do
          last_addded_application = JobApplication.last
          expect(user.job_applications.find_by(**job_application)).to eq(last_addded_application)
        end
      end

      response "422", "Validation failed if alredy applied" do
        before { user.job_applications.create!(job_application) }

        schema type: :object, properties: { "$ref" => "#/components/schemas/errors_object" }

        run_test! do
          expect(user.job_applications.count).to eq(1)
        end
      end
    end
  end
end
