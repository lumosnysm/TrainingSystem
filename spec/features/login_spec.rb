require "rails_helper"

RSpec.feature "Login", type: :feature, js: true do
  let(:user) {FactoryBot.create :user}

  scenario "User login" do
    user_login user, true
    expect(page).to have_content "Signed in successfully."
  end

  scenario "Login fail" do
    user_login user, false
    expect(page).to have_content "Invalid Email or password."
  end

  scenario "Login after logged in" do
    user_login user, true
    visit "/account/sign_in"
    expect(page).to have_content "You are already signed in."
  end

  scenario "See profile" do
    user_login user, true
    expect(page).to have_content "User Profile"
    click_on "User Profile"
    expect(current_path).to eql(user_path(user))
  end

  def user_login someone, correct_password
    visit "/account/sign_in"
    fill_in "Username", with: someone.email
    if correct_password
      fill_in "Password", with: "111111"
    else
      fill_in "Password", with: "222222"
    end
    click_button "Log in"
  end
end
