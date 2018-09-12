class Member < ApplicationRecord
  belongs_to :course
  belongs_to :user
  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| !controller.nil? ? controller.current_user : User.first}
  acts_as_paranoid
end
