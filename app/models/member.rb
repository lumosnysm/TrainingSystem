class Member < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :activities, as: :trackable, class_name: PublicActivity::Activity.name,
   dependent: :destroy
  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| !controller.nil? ? controller.current_user : User.first}
  acts_as_paranoid
end
