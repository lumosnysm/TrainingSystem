class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :courses_in, class_name: Member.name,
    foreign_key: :user_id
  has_many :courses, through: :courses_in, source: :course
  scope :trainee, ->{where supervisor: false}
  scope :supervisor, ->{where supervisor: true}
  scope :not_in_course, ->(course) {where.not id: course.users.ids}
  has_many :user_subjects, class_name: UserSubject.name,
           foreign_key: :user_id
  has_many :courses_started, through: :user_subjects, source: :course

  def check_course_start course
    user_subjects.where(course_id: course.id).count == 0
  end

  def count_courses_locked
    courses.distinct.courses_locked.count
  end

  def count_courses_inprogress
    courses.courses_opening.
    find_by_ids(user_subjects.find_by_status(false).
    group(:course_id).pluck(:course_id)).count
  end

  def count_courses_not_start
    courses.distinct.count - courses_started.distinct.count
  end

  def count_courses_completed
    cs_started = courses_started.not_closed.distinct.count
    cs_started - count_courses_inprogress
  end
end
