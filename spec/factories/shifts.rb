# frozen_string_literal: true

FactoryBot.define do
  factory :shift do
    start_time { "2021-01-24 10:00:0" }
    end_time { "2021-01-24 18:00:00" }
    job
  end
end
