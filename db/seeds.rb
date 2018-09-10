User.create! email: "admin@ts.com",
  password: "111111",
  password_confirmation: "111111",
  supervisor: 1

User.create! email: "user@ts.com",
  password: "111111",
  password_confirmation: "111111"

50.times do |n|
  email = "user#{n+1}@ts.com"
  password = "111111"
  password_confirmation = "111111"
  User.create! email: email,
    password: password,
    password_confirmation: password_confirmation
end

50.times do |n|
  email = "admin#{n+1}@ts.com"
  password = "111111"
  password_confirmation = "111111"
  User.create! email: email,
    password: password,
    password_confirmation: password_confirmation,
    supervisor: 1
end

10.times do |n|
  name = FFaker::Lorem.phrase
  description = FFaker::Lorem.sentence 50
  start_date = FFaker::Time.between 7.days.ago, Date.today
  end_date = start_date + 4.weeks
  Course.create! name: name,
    description: description,
    start_date: start_date,
    end_date: end_date,
    status: 1
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
    status: 1
end

50.times do |n|
  5.times do |m|
    detail = FFaker::Lorem.sentence 10
    subject_id = n+1
    Task.create! detail: detail,
      subject_id: subject_id
  end
end

10.times do |n|
  user_id = 2
  course_id = n+1
  Member.create! user_id: user_id,
    course_id: course_id
end
