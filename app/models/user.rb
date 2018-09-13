class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_many :courses_in, class_name: Member.name,
    foreign_key: :user_id, dependent: :delete_all
  has_many :courses, through: :courses_in, source: :course
  has_many :user_subjects, class_name: UserSubject.name,
    foreign_key: :user_id, dependent: :destroy
  has_many :courses_started, through: :user_subjects, source: :course
  has_many :reports, dependent: :destroy
  has_many :activities, as: :owner, class_name: PublicActivity::Activity.name,
   dependent: :destroy
  scope :trainee, ->{where supervisor: false}
  scope :supervisor, ->{where supervisor: true}
  scope :not_in_course, ->(course) {where.not id: course.users.ids}
  scope :lastest, ->{order created_at: :desc}

  def check_course_start course
    user_subjects.where(course_id: course.id).count > 0
  end

  def check_subject_start subject
    user_subject = UserSubject.find_by user_id: self.id, subject_id: subject.id
    return false unless user_subject
    UserTask.where(user_subject_id: user_subject.id).count > 0
  end

  def count_courses_locked
    courses.where(status: :locked).count
  end

  def count_courses_inprogress
    @courses = courses_started.distinct.where(status: :opening)
    return @courses.reject{|c| c.subjects.count == user_subjects.find_by_course(c).count}.count
  end

  def count_courses_completed
    @courses = courses_started.where(id: courses.ids).distinct.where(status: :opening)
    return @courses.select{|c| c.subjects.count == user_subjects.find_by_course(c).count}.count
  end

  def check_course_done course
    user_subjects.where(course_id: course.id).find_by_status(true).count ==
      course.subjects.count
  end

  def check_subject_done subject
    user_subject = UserSubject.find_by(user_id: self.id, subject_id: subject.id)
    return false unless user_subject
    return user_subject.status
  end

  def check_task_done task, subject
    user_subject = UserSubject.find_by(user_id: self.id, subject_id: subject.id)
    return false unless user_subject
    user_task = UserTask.find_by(task_id: task.id, user_subject_id: user_subject.id)
    return false unless user_task
    return user_task.status
  end

  def correct_user user
    self == user
  end
end
