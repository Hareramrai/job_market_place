# frozen_string_literal: true

require "rails_helper"

RSpec.describe Job, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:language_list) }
    it { is_expected.to validate_numericality_of(:rate).is_greater_than(0) }

    describe "shifts validation" do
      let!(:job) { build(:job) }

      it "should have at least one shift" do
        job.shifts = build_list(:shift, 1)
        job.valid?
        expect(job.errors.messages[:shifts]).to be_blank
      end

      it "shouldn't have more than 7 shifts" do
        job.shifts = build_list(:shift, 8)
        job.valid?

        expect(job.errors.messages[:shifts]).to be_present
      end
    end
  end

  describe "#paying" do
    let!(:job) do
      job = build(:job)
      job.shifts = build_list(:shift, 2)
      job.save!
      job
    end

    it "returns the multiplication of working_hours & rate" do
      expect(job.paying).to eq(job.rate * job.total_hours)
    end

    it "returns total_hours as 16 hours" do
      expect(job.total_hours).to eq(16)
    end
  end
end
