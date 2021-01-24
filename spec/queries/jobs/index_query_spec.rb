# frozen_string_literal: true

require "rails_helper"

RSpec.describe Jobs::IndexQuery do
  include_context "sample jobs"

  describe "#call" do
    context "search by title" do
      context "when title matches" do
        let(:search_params) { { title: "software" } }

        it "returns the searched result" do
          expect(subject.call(search_params)).to eq([english_job, german_job])
        end
      end

      context "when title does not match" do
        let(:search_params) { { title: "nomatch" } }

        it "returns no record" do
          expect(subject.call(search_params)).to be_blank
        end
      end
    end

    context "search by language" do
      context "when language matches" do
        let(:search_params) { { language: "english" } }

        it "returns the searched result" do
          expect(subject.call(search_params)).to eq([english_job])
        end
      end

      context "when language does not match" do
        let(:search_params) { { language: "hindi" } }

        it "returns no record" do
          expect(subject.call(search_params)).to be_blank
        end
      end
    end
  end
end
