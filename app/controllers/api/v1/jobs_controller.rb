# frozen_string_literal: true

class Api::V1::JobsController < Api::BaseController
  before_action :authorize_request

  # GET /jobs
  def index
    @jobs = Jobs::IndexQuery.new(Job.includes(:shifts)).call(search_params)
  end

  # POST /jobs
  def create
    @job = Job.new(job_params)
    @job.save!
  end

  private

    def job_params
      params
        .require(:job)
        .permit(:title, :rate, :language_list, shifts_attributes: shifts_params)
    end

    def shifts_params
      [:id, :start_time, :end_time]
    end

    def search_params
      params.permit(:title, :language)
    end
end
