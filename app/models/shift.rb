# frozen_string_literal: true

class Shift < ApplicationRecord
  belongs_to :job

  # validations
  validates :start_time, :end_time, presence: true
  validates_datetime :start_time, before: :end_time, allow_nil: true
  validates_datetime :end_time,
                     before: ->(record) { record.start_time + 24.hours },
                     allow_nil: true

  def working_hours
    (end_time - start_time) / 1.hour
  end
end
