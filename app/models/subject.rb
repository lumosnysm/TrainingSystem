class Subject < ApplicationRecord
  enum status: {locked: 0, opening: 1, closed: 2}
  belongs_to :course
  has_many :tasks, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  validates :start_date, :end_date, :name, :detail, presence: true
  accepts_nested_attributes_for :tasks, allow_destroy: true
  scope :sort_by_date, ->{order start_date: :asc}
  has_many :user_subjects, dependent: :destroy
  extend FriendlyId
  friendly_id :name, use: %i(slugged finders)

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
