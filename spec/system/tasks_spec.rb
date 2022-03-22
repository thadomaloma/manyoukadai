require 'rails_helper'

RSpec.describe "Task management function", type: :system do
  def user_login
		visit new_session_path
		fill_in "Email", with: "user@example.com"
		fill_in "Password", with: "password"
		click_on "login"
	end

	describe 'New creation function' do
		before do
			@user = FactoryBot.create(:user, name: "general user", email: "user@example.com", password: "password")
		end
		context 'When creating a new task' do
			it 'The created task is displayed' do
				user_login
				task = FactoryBot.create(:task, user_id: @user.id, title: 'task')
				visit tasks_path
				expect(page).to have_content 'task'
			end
		end
	end

	describe 'List display function' do
		before do
			@user = FactoryBot.create(:user, name: "general user", email: "user@example.com", password: "password")
		end
		context 'When transitioning to the list screen' do
			it 'The created task list is displayed' do
				user_login
				visit new_task_path
				fill_in "Title", with: "task name"
				fill_in "Detail", with: "task details"
				click_on "submit"
				visit tasks_path
				expect(page).to have_content 'task name'
				expect(page).to have_content 'task details'
			end
		end
		context 'When transitioned to any task details screen' do
			it 'The content of the relevant task is displayed' do
				user_login
				visit new_task_path
				fill_in "Title", with: "task name2"
				fill_in "Detail", with: "task details2"
				click_on "submit"
				visit tasks_path
				click_on "Show"
				expect(page).to have_content 'task name2'
				expect(page).to have_content 'task details2'
			end
		end
		context 'When tasks are arranged in descending order of creation date and time' do
			it 'New task is displayed at the top' do
				user_login
				task1 = FactoryBot.create(:task, user_id: @user.id, title: 'task1', detail: 'task1_detail')
				task2 = FactoryBot.create(:task, user_id: @user.id, title: 'task2', detail: 'task2_detail')
				visit tasks_path
				task_list = all('.task_row')
				@tasks = Task.all
				expect(@tasks).to match_array [task2, task1]
			end
		end
		context "When registering a new task" do
			it "can also register the deadline" do
				user_login
				task1 = FactoryBot.create(:task, user_id: @user.id, title: 'task1', detail: 'task1_detail', deadline: "2022-02-15")
				visit tasks_path
				expect(page).to have_content "2022-02-15"
			end
		end
		context "When registering a new task" do
			it "can also register the status" do
				user_login
				task1 = FactoryBot.create(:task, user_id: @user.id, title: 'task1', detail: 'task1_detail', status: "completed")
				visit tasks_path
				expect(page).to have_content "completed"
			end
		end
		context 'When sort by deadline link is clicked' do
			it 'Task are sorted based on deadline in descending' do
				user_login
				task1 = FactoryBot.create(:task, user_id: @user.id, title: 'task1', detail: 'task1_detail', deadline: "2022-01-31")
				task2 = FactoryBot.create(:task, user_id: @user.id, title: 'task2', detail: 'task2_detail', deadline: "2022-02-1")
				visit tasks_path
				click_on "Deadline"
				task_list = all('.task_row')
				@tasks = Task.all
				expect(@tasks).to match_array [task1, task2]
			end
		end
		context "When you click the link to sort by priority" do
			it "a list of tasks sorted in order of priority is displayed" do
				user_login
				task1 = FactoryBot.create(:task, user_id: @user.id, title: 'task1', detail: 'task1_detail', priority: 1)
				task2 = FactoryBot.create(:task, user_id: @user.id, title: 'task2', detail: 'task2_detail', priority: 2)
				task3 = FactoryBot.create(:task, user_id: @user.id, title: 'task3', detail: 'task3_detail', priority: 3)
				visit tasks_path
				click_on "Priority"
				@tasks = Task.all
				expect(@tasks).to match_array [task1, task2, task3]
			end
		end
		context 'When Sort by status link is clicked' do
			it 'Task are sorted based on status in descending' do
				user_login
				task1 = FactoryBot.create(:task, user_id: @user.id, title: 'task1', detail: 'task1_detail', status: "started")
				task2 = FactoryBot.create(:task, user_id: @user.id, title: 'task2', detail: 'task2_detail', status: "completed")
				visit tasks_path
				click_on "Status"
				task_list = all('.task_row')
				@tasks = Task.all
				expect(@tasks).to match_array [task2, task1]
			end
		end
	end

	describe 'Search function' do
		before do
			@user = FactoryBot.create(:user, name: "general user", email: "user@example.com", password: "password")
			task1 = FactoryBot.create(:task, user_id: @user.id, title: "task1 title test", detail: "task1 detail test", status: "started")
			task2 = FactoryBot.create(:task, user_id: @user.id, title: "task2 title test", detail: "task2 detail test", status: "completed")
		end
		context 'If you do a fuzzy search by Title' do
			it "Filter by tasks that include search keywords" do
				user_login
				visit tasks_path
				fill_in "Search by title", with: "task1"
				click_on "search"
				expect(page).to have_content 'task1'
			end
		end
		context 'When you search for status' do
			it "Tasks that exactly match the status are narrowed down" do
				user_login
				visit tasks_path
				select('started', from: 'Search by Status')
				click_on "search"
				expect(page).to have_content 'started'
			end
		end
		context 'Title performing fuzzy search of title and status search' do
			it "Narrow down tasks that include search keywords in the Title and exactly match the status" do
				user_login
				visit tasks_path
				fill_in "Search by title", with: "task1"
				select('started', from: 'Search by Status')
				click_on "search"
				expect(page).to have_content 'task1'
				expect(page).to have_content 'started'
			end
		end
	end
end
