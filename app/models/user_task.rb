class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user_subject
  has_many :activities, as: :trackable, class_name: PublicActivity::Activity.name,
   dependent: :destroy
  scope :user_task_done, ->{where status: true}
  scope :find_by_status, ->(status){where status: status}
  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| !controller.nil? ? controller.current_user : User.first}
end
