require "rails_helper"

RSpec.feature "Sign Up", type: :feature, js: true do
  let(:user) {FactoryBot.create :user}
  let(:admin) {FactoryBot.create :admin}

  scenario "Admin create account" do
    user_login admin
    expect(page).to have_content "Create Account"
    click_on "Create Account"
    expect(current_path).to eql(new_user_registration_path)
    fill_in "Email", with: "test_user@ts.com"
    fill_in "Username", with: "test_user"
    fill_in "Password", with: "111111"
    fill_in "Password confirmation", with: "111111"
    click_button "Sign Up"
    expect(page).to have_content "You have signed up successfully."
  end

  scenario "User create account" do
    user_login user
    expect(page).to_not have_content "Create Account"
    visit "/account/sign_up"
    expect(page).to have_content "You are not authorized to access this page."
  end

  def user_login someone
    visit "/account/sign_in"
    fill_in "Username", with: someone.email
    fill_in "Password", with: "111111"
    click_button "Log in"
  end
end
