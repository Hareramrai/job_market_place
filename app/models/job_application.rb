# frozen_string_literal: true

class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job

  # validations
  validates :user_id, uniqueness: { scope: :job_id,
                                    message: "should apply once per job", }
end
