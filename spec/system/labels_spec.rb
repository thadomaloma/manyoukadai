require 'rails_helper'

RSpec.describe "Labels", type: :system do
  def user_login
		visit new_session_path
		fill_in "Email", with: "user@example.com"
		fill_in "Password", with: "password"
		click_on "login"
	end

	describe "label CRUD function" do
		before do
			@user = FactoryBot.create(:user, name: "general user", email: "user@example.com", password: "password")
		end
		it "can create a lable" do
			user_login
			visit new_label_path
			fill_in "Name", with: "lable1"
			click_on "create label"
			expect(page).to have_content "lable1"
		end
		it "can display list of labels" do
			user_login
			@label1 = FactoryBot.create(:label, name: "test_label1")
			@label2 = FactoryBot.create(:label, name: "test_label2")
			visit labels_path
			expect(page).to have_content "test_label1"
			expect(page).to have_content "test_label2"
		end
		it "can show detail of a label" do
			user_login
			@label = FactoryBot.create(:label, name: "test_label")
			visit labels_path
			click_on "show"
			expect(page).to have_content "test_label"
		end
		it "can edit a label" do
			user_login
			@label = FactoryBot.create(:label, name: "test_label")
			visit labels_path
			click_on "edit"
			fill_in "Name", with: "edited_label"
			click_on "edit label"
			expect(page).to have_content "edited_label"
		end
		it "can destroy a label" do
			user_login
			@label = FactoryBot.create(:label, name: "test_label")
			visit labels_path
			click_on "delete"
			expect(page).not_to have_content "test_label"
		end
	end

	describe "when create a task" do
		before do
			@user = FactoryBot.create(:user, name: "general user", email: "user@example.com", password: "password")
			@label1 = FactoryBot.create(:label, name: "test_label1")
			@label2 = FactoryBot.create(:label, name: "test_label2")
		end
		it "can register labels" do
			user_login
			visit new_task_path
			fill_in "Title", with: "task title"
			fill_in "Detail", with: "task detail"
			page.check("test_label1")
			page.check("test_label2")
			click_on "submit"
			expect(page).to have_content "test_label1"
			expect(page).to have_content "test_label2"
		end
	end

	describe "search label" do
		before do
			@user = FactoryBot.create(:user, name: "general user", email: "user@example.com", password: "password")
			@label1 = FactoryBot.create(:label, name: "test_label1")
			@label2 = FactoryBot.create(:label, name: "test_label2")
		end
		it "can search task by label" do
			user_login
			@task1 = FactoryBot.create(:task, user_id: @user.id, title: "task_title1", detail: "task_detail1", label_ids: Label.first.id)
			@task2 = FactoryBot.create(:task, user_id: @user.id, title: "task_title2", detail: "task_detail2", label_ids: Label.second.id)
			visit tasks_path
			select('test_label1', from: 'Search by label')
			click_on "search"
			expect(page).to have_content 'task_title1'
			expect(page).not_to have_content "task_title2"
		end
	end
end
