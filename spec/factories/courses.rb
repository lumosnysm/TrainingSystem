require "ffaker"

FactoryBot.define do
  factory :course do
    name {FFaker::Lorem.phrase}
    description {FFaker::Lorem.sentence 50}
    start_date {FFaker::Time.between 7.days.ago, Date.today}
    end_date {FFaker::Time.between 7.days.ago, Date.today}
  end
end
