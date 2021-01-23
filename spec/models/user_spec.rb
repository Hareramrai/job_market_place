# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }

    context "uniqueness" do
      subject { build(:user) }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    end
  end
end
