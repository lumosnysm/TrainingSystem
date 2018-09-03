class UserSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :user
  belongs_to :course
end
