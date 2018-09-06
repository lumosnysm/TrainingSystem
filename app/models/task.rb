class Task < ApplicationRecord
  belongs_to :subject
  validates :detail, presence: true
end
