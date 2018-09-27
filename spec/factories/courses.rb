require "ffaker"

FactoryBot.define do
  factory :course, class: Course do
    name {FFaker::Lorem.phrase}
    description {FFaker::Lorem.sentence 50}
    start_date {FFaker::Time.between 7.days.ago, Date.today}
    end_date {FFaker::Time.between 7.days.ago, Date.today}
    status {1}
  end

  factory :ccourse, class: Course do
    name {FFaker::Lorem.phrase}
    description {FFaker::Lorem.sentence 50}
    start_date {FFaker::Time.between 7.days.ago, Date.today}
    end_date {FFaker::Time.between 7.days.ago, Date.today}
    status {2}
  end
end
