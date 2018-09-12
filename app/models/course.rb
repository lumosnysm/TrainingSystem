class Course < ApplicationRecord
  enum status: {locked: 0, opening: 1, closed: 2}
  has_many :subjects, dependent: :destroy
  has_many :users_in, class_name: Member.name,
    foreign_key: :course_id, dependent: :delete_all
  has_many :users, through: :users_in, source: :user
  has_many :user_subjects, dependent: :destroy
  scope :lastest, ->{order updated_at: :desc}
  scope :fields, ->{select :id, :name, :start_date, :end_date, :status}
  scope :find_by_ids, ->(ids){where id: ids}
  scope :find_by_status, ->(status){where status: status}
  scope :not_closed, ->{where.not status: :closed}
  scope :sort_by_date, ->{order start_date: :asc}
  validates :start_date, :end_date, :name, presence: true
  accepts_nested_attributes_for :subjects, allow_destroy: true
  delegate :name, to: :user, prefix: :user, allow_nil: true
  has_many :user_subjects
  extend FriendlyId
  friendly_id :name, use: %i(slugged finders)
  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| !controller.nil? ? controller.current_user : User.first}
end
