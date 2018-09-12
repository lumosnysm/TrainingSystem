class UserSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :user
  belongs_to :course
  has_many :user_tasks, dependent: :destroy
  accepts_nested_attributes_for :user_tasks
  scope :find_by_course, ->(course){where course_id: course.id}
  scope :find_by_status, ->(status){where status: status}
  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| !controller.nil? ? controller.current_user : User.first}
end
