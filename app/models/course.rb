class Course < ApplicationRecord
  has_many :subjects
  has_many :users_in, class_name: Member.name,
    foreign_key: :course_id
  has_many :users, through: :users_in, source: :user
end
