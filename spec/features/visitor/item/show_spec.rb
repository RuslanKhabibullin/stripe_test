require "rails_helper"

feature "Visit single item page" do
  let!(:item) { create :item, price: 5.50 }

  scenario "Visitor can see single item page" do
    visit item_path(item)

    expect(page).to have_content(item.title)
    expect(page).to have_content(item.description)
    expect(page).to have_content("5.50$")
  end
end
