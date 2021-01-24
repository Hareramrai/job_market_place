# frozen_string_literal: true

json.id job.id
json.title job.title
json.languages job.language_list
json.paying job.paying

json.shifts job.shifts do |shift|
  json.id shift.id
  json.start_time shift.start_time
  json.end_time shift.end_time
  json.working_hours shift.working_hours
end
