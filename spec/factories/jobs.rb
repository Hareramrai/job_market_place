# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    sequence :title do |n|
      "title#{n}"
    end
    rate { "9.99" }
    language_list { "german" }
  end
end
