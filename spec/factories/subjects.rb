require "ffaker"

FactoryBot.define do
  factory :subject do
    name {FFaker::Lorem.phrase}
    description {FFaker::Lorem.sentence 50}
    detail {FFaker::Lorem.sentence 100}
    course_id {1}
    start_date {FFaker::Time.between 7.days.ago, Date.today}
    end_date {FFaker::Time.between 7.days.ago, Date.today}
    status {1}
  end
end
