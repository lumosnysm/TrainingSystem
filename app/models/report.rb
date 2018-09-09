class Report < ApplicationRecord
  belongs_to :user
  validates :title, :content, presence: true
  scope :sort_by_date, ->{order updated_at: :desc}
end
