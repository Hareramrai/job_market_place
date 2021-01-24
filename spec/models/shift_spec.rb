# frozen_string_literal: true

require "rails_helper"

RSpec.describe Shift, type: :model do
  describe "#working_hours" do
    let!(:job) do
      job = build(:job)
      job.shifts << build(:shift)
      job.save!
      job
    end

    it "returns the difference of start_time & end_time" do
      expect(job.shifts.first.working_hours).to eq(8)
    end
  end
end
