require "rails_helper"

feature "Visit my items page" do
  include_context "when current user signed in"

  background do
    create :item, title: "Item3", description: "Test description", price: 5.00

    bought_item = create :item, title: "Item", description: "Hi!", price: 2.50
    create :payment_session, :fulfilled, item: bought_item, user: current_user

    failed_item = create :item, title: "Item2", description: "Hi!", price: 3.00
    create :payment_session, :failed, item: failed_item, user: current_user
  end

  scenario "Signed in user can see bought items" do
    visit user_items_path(current_user)

    expect(page).to have_content("Item")
    expect(page).not_to have_content("Item2")
    expect(page).not_to have_content("Item3")
  end
end
