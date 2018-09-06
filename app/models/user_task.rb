class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user_subject
  scope :user_task_done, ->{where status: true}
  scope :find_by_status, ->(status){where status: status}
end
