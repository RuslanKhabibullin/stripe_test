require "rails_helper"

feature "Update current user profile" do
  include_context "when current user signed in"

  let(:successfull_message) do
    "Your account has been updated successfully."
  end

  background { visit edit_user_registration_path }

  scenario "Current user can update his profile with valid data" do
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"
    fill_in "Email", with: "john@doe.com"
    click_button "Update"

    expect(page).to have_content(successfull_message)
  end

  scenario "Current user can update his password with valid data" do
    fill_in "Password", with: "new_password_1"
    fill_in "Password confirmation", with: "new_password_1"
    fill_in "Current password", with: "12345678"
    click_button "Update"

    expect(page).to have_content(successfull_message)
  end

  scenario "Current user can't update his profile with invalid data" do
    fill_in "Email", with: "invalid email"
    click_button "Update"

    expect(page).not_to have_content(successfull_message)
  end

  scenario "Current user can't update his password without valid current password" do
    fill_in "Password", with: "new_password_1"
    fill_in "Password confirmation", with: "new_password_1"
    fill_in "Current password", with: "invalid"
    click_button "Update"

    expect(page).not_to have_content(successfull_message)
  end
end
