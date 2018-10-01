require "rails_helper"

RSpec.feature "User courses", type: :feature, js: true do
  let(:user) {FactoryBot.create :user}
  let(:course) {FactoryBot.create :course}
  let(:ccourse) {FactoryBot.create :ccourse}

  scenario "User view all courses" do
    user_login user
    expect(page).to have_content "My Course"
    click_on "My Course"
    expect(current_path).to eql(courses_path)
  end

  scenario "User start course" do
    user_login user
    assign_user_to_course course
    click_on "My Course"
    expect(page).to have_content course.name
    expect(page).to have_button "Start"
    click_button "Start"
    expect(user.courses_started.count).to eql(1)
  end

  scenario "User view a not started course" do
    user_login user
    assign_user_to_course course
    click_on "My Course"
    expect(page).to have_content course.name
    click_on course.name
    expect(page).to have_content "This course is not started."
  end

  scenario "User view a started course" do
    user_login user
    assign_user_to_course course
    click_on "My Course"
    click_button "Start"
    click_on "My Course"
    expect(page).to have_content course.name
    click_on course.name
    expect(current_path).to eql(course_path(course))
  end

  scenario "User view a finished course" do
    user_login user
    assign_user_to_course ccourse
    visit "/courses"
    expect(page).to_not have_content ccourse.name
    FactoryBot.create :user_subject
    visit course_path(ccourse)
    expect(page).to have_content "Course closed."
  end

  def user_login someone
    visit "/account/sign_in"
    fill_in "Username", with: someone.email
    fill_in "Password", with: "111111"
    click_button "Log in"
  end

  def assign_user_to_course course
    FactoryBot.create :member
    FactoryBot.create :subject
  end
end
