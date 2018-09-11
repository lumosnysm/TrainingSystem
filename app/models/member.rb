class Member < ApplicationRecord
  belongs_to :course
  belongs_to :user
  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| controller.current_user}
  acts_as_paranoid
end
