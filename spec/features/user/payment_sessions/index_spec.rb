require "rails_helper"

feature "Visit payment attempts page" do
  include_context "when current user signed in"

  def create_payment_session(state)
    item = create :item
    create :payment_session, item: item, user: current_user, state: state
  end

  let!(:fulfilled_payment) { create_payment_session "fulfilled" }
  let!(:failed_payment) { create_payment_session "failed" }
  let!(:created_payment) { create_payment_session "created" }
  let!(:paid_payment) { create_payment_session "paid" }

  scenario "Signed in user can see payment sessions" do
    visit user_payment_sessions_path(current_user)

    [
      fulfilled_payment,
      failed_payment,
      created_payment,
      paid_payment
    ].each do |payment_session|
      within("tr#payment_session_row_#{payment_session.id}") do
        expect(page).to have_content(payment_session.id)
        expect(page).to have_content(payment_session.item.title)
        expect(page).to have_content(payment_session.state)
        expect(page).to have_content(
          I18n.l(
            payment_session.created_at.in_time_zone("UTC"),
            format: :time_with_zone
          )
        )
      end
    end
  end
end
