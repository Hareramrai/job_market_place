# frozen_string_literal: true

class Users::GenerateTokenService < ApplicationService
  def initialize(user)
    @user = user
  end

  def call
    user.token_expires_at = token_expires_at
    user.regenerate_token
  end

  private

    attr_reader :user

    def token_expires_in
      Rails.application.secrets.token_expires_in.to_i
    end

    def token_expires_at
      Time.current + token_expires_in.seconds
    end
end
