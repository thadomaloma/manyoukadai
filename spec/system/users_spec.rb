require 'rails_helper'

RSpec.describe "Users", type: :system do
  def user_login
		visit new_session_path
		fill_in "Email", with: "user@example.com"
		fill_in "Password", with: "password"
		click_on "login"
	end

	def admin_login
		visit new_session_path
		fill_in "Email", with: "admin_user@example.com"
		fill_in "Password", with: "password"
		click_on "login"
	end

	describe "User registration test" do
		it "Being able to newly register users" do
			visit new_user_path
			fill_in "Name", with: "test_name"
			fill_in "Email", with: "test_email@example.com"
			fill_in "Password", with: "password"
			fill_in "Password confirmation", with: "password"
			click_on "create account"
			expect(page).to have_content "test_email@example.com"
		end

		context "When the user tries to jump to the task list screen without logging in" do
			it "transition to the login screen" do
				visit tasks_path
				expect(page).to have_current_path(new_session_path)
			end
		end
	end

	describe "Testing session functionality" do
		before do
			FactoryBot.create(:user, name: "user", email: "user@example.com", password: "password")
			FactoryBot.create(:user, name: "admin", email: "admin_user@example.com", password: "password")
		end
		it "Be able to log in" do
			user_login
			expect(page).to have_content "user@example.com"
		end
		it "You can jump to your details screen (My Page)" do
			user_login
			click_on "Profile"
			expect(page).to have_content "user@example.com"
		end

		it "When a general user jumps to another person's details screen, it will transition to the task list screen" do
			user_login
			@user = User.find_by(name: "admin")
			visit user_path(@user.id)
			expect(page).to have_current_path(tasks_path)
		end
	end

end
