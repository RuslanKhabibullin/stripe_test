require "rails_helper"

feature "Sign out" do
  include_context "when current user signed in"

  scenario "Current user can sign out" do
    visit items_path

    expect(page).not_to have_content("Log in")
    expect(page).to have_content("Log out")

    click_link "Log out"

    expect(page).to have_content("Signed out successfully.")
    expect(page).to have_content("Log in")
  end
end
