require "rails_helper"

feature "Sign in" do
  let!(:user) do
    create(
      :user,
      email: "user@email.com",
      password: "12345678",
      password_confirmation: "12345678"
    )
  end

  background { visit new_user_session_path }

  scenario "Visitor sign in with invalid data" do
    fill_form(:user, email: "wrong@email.com", password: "12345678")
    click_button "Log in"

    expect(page).to have_content "Invalid"
  end

  scenario "Visitor sign in with valid data" do
    fill_form(:user, email: user.email, password: "12345678")
    click_button "Log in"

    expect(page).to have_content "Signed in"
  end
end
