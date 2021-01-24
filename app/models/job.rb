# frozen_string_literal: true

class Job < ApplicationRecord
  acts_as_taggable_on :languages

  has_many :shifts, dependent: :destroy
  has_many :job_applications, dependent: :destroy
  has_many :users, through: :job_applications

  # Validations
  validates :title, :rate, presence: true
  validates :rate, numericality: { greater_than: 0 }
  validates :language_list, presence: true
  validates :shifts, length: { minimum: 1, maximum: 7 }

  accepts_nested_attributes_for :shifts,
                                reject_if: proc { |attributes|
                                             attributes["start_time"].blank? &&
                                               attributes["end_time"].blank?
                                           }

  def paying
    rate * total_hours
  end

  def total_hours
    shifts.sum(&:working_hours)
  end
end
