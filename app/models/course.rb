class Course < ApplicationRecord
  has_many :subjects, dependent: :destroy
  has_many :users_in, class_name: Member.name,
    foreign_key: :course_id, dependent: :destroy
  has_many :users, through: :users_in, source: :user
  scope :lastest, ->{order updated_at: :desc}
  scope :fields, ->{select :id, :name, :start_date, :end_date, :status}
  validates :start_date, :end_date, :name, presence: true
  accepts_nested_attributes_for :subjects, allow_destroy: true
  delegate :name, to: :user, prefix: :user, allow_nil: true
end
