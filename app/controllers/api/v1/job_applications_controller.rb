# frozen_string_literal: true

class Api::V1::JobApplicationsController < Api::BaseController
  before_action :authorize_request

  # POST /job_applications
  def create
    @job_application = current_user.job_applications.build(job_application_params)
    @job_application.save!
  end

  private

    def job_application_params
      params.require(:job_application).permit(:user_id, :job_id)
    end
end
