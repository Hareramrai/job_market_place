# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_secure_token :token

  has_many :job_applications, dependent: :destroy
  has_many :jobs, through: :job_applications

  attribute :password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, email: true, allow_blank: true
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 8 }, if: :password_exist?

  before_save { email.downcase! }

  def token_expired?
    token_expires_at < Time.current
  end

  private

    def password_exist?
      password&.length&.positive?
    end
end
