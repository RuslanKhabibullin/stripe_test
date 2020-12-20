shared_context "when current user signed in" do
  let!(:current_user) do
    create(:user, password: "12345678", password_confirmation: "12345678")
  end

  background do
    visit new_user_session_path
    fill_in "Email", with: current_user.email
    fill_in "Password", with: "12345678"
    click_button "Log in"
  end
end
