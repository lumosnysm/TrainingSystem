class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :courses_in, class_name: Member.name,
    foreign_key: :user_id
  has_many :courses, through: :courses_in, source: :course
  scope :trainee, ->{where supervisor: false}
  scope :supervisor, ->{where supervisor: true}
  scope :not_in_course, ->(course) {where.not id: course.users.ids}
end
