# frozen_string_literal: true

RSpec.shared_context "sample jobs" do
  let!(:english_job) do
    job = build(:job, language_list: "english", title: "software job 1")
    job.shifts << build(:shift)
    job.save!
    job
  end

  let!(:german_job) do
    job = build(:job, language_list: "german", title: "software job 2")
    job.shifts << build(:shift)
    job.save!
    job
  end
end
