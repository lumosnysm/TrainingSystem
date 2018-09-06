class Subject < ApplicationRecord
  belongs_to :course
  has_many :tasks, dependent: :destroy
  validates :start_date, :end_date, :name, :detail, presence: true
  accepts_nested_attributes_for :tasks, allow_destroy: true
  has_many :user_subjects
end
