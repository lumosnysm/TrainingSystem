User.create! email: "admin@ts.com",
  password: "111111",
  password_confirmation: "111111",
  supervisor: true

User.create! email: "user@ts.com",
  password: "111111",
  password_confirmation: "111111"

10.times do |n|
  name = FFaker::Lorem.phrase
  description = FFaker::Lorem.sentence 50
  start_date = FFaker::Time.between 7.days.ago, Date.today
  end_date = start_date + 4.weeks
  Course.create! name: name,
    description: description,
    start_date: start_date,
    end_date: end_date,
    status: false
end

50.times do |n|
  name = FFaker::Lorem.phrase
  description = FFaker::Lorem.sentence 50
  detail = FFaker::Lorem.sentence 100
  course_id = rand(1..10)
  course = Course.find_by(id: course_id)
  start_date = FFaker::Time.between course.start_date, course.end_date - 2.days
  end_date = start_date + 2.days
  Subject.create! name: name,
    description: description,
    detail: detail,
    course_id: course_id,
    start_date: start_date,
    end_date: end_date,
    status: false
end

50.times do |n|
  detail = FFaker::Lorem.sentence 10
  subject_id = rand(1..50)
  Task.create! detail: detail,
    subject_id: subject_id
end

5.times do |n|
  user_id = 2
  course_id = n+1
  Member.create! user_id: user_id,
    course_id: course_id
end
