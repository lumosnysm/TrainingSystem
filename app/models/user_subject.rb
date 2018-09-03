class UserSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :user
  belongs_to :course
  has_many :user_tasks
end
