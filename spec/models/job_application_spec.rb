# frozen_string_literal: true

require "rails_helper"

RSpec.describe JobApplication, type: :model do
  include_context "sample jobs"

  describe "validations" do
    let(:user) { create(:user) }
    before { JobApplication.create!(user: user, job: english_job) }

    it "should not allow to apply for same job by a user" do
      expect do
        JobApplication.create!(user: user, job: english_job)
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
