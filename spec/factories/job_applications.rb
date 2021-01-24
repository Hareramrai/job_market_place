# frozen_string_literal: true

FactoryBot.define do
  factory :job_application do
    user
    job
  end
end
