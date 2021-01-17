require "rails_helper"

feature "Visit single item page" do
  include_context "when current user signed in"

  let!(:item) { create :item, price: 5.50, title: "Item", description: "Yo" }

  scenario "Signed in user can see single item page", js: true do
    visit item_path(item)

    expect(page).to have_content("Item")
    expect(page).to have_content("Yo")
    expect(page).to have_content("5.50$")
    expect(page).to have_button("Checkout")
  end

  context "when item already bought by current user" do
    let!(:item) do
      item = create :item, price: 5.50, title: "Item", description: "Yo"
      create :payment_session, :fulfilled, item: item, user: current_user
      item
    end

    scenario "Signed in user cant buy same item twice", js: true do
      visit item_path(item)

      expect(page).to have_content("Item")
      expect(page).not_to have_button("Checkout")
      expect(page).to have_content("Already bought")
    end
  end
end
