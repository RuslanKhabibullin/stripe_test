require "rails_helper"

feature "Visit items page" do
  include_context "when current user signed in"

  background do
    create(
      :item,
      title: "Test",
      description: "Test description",
      price: 5.00
    )
  end

  scenario "Signed in user can see items page" do
    visit items_path

    expect(page).to have_content("Test")
    expect(page).to have_content("Test description")
    expect(page).to have_content("5.00$")
  end
end
