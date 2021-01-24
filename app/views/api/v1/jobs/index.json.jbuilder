# frozen_string_literal: true

json.jobs @jobs do |job|
  json.partial! "job", job: job
end
