require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation test' do

    before do
      @user = FactoryBot.create(:user, name: "general user", email: "user@example.com", password: "password")
    end

    context 'If the task Title is empty' do
      it "will be caught in validation" do
        task = Task.new(user_id: @user.id, title: '', detail: 'detail')
        expect(task).not_to be_valid
      end
    end

    context 'If the task details are empty' do
      it 'Validation is caught' do
        task = Task.new(user_id: @user.id, title: 'test_title', detail: '')
        expect(task).not_to be_valid
      end
    end

    context 'If the task Title and details are described' do
      it 'Validation passes' do
        task = Task.new(user_id: @user.id, title: 'test_title', detail: 'test_detail')
        expect(task).to be_valid
      end
    end
  end

  describe 'Search function' do
    before do
      @user = FactoryBot.create(:user, name: "general user", email: "user@example.com", password: "password")
    end
    # You can change the contents of the test data as needed.
    let!(:task1) { FactoryBot.create(:task, user_id: @user.id, title: "task1 title", detail: "task1 detail", status: "started") }
    let!(:task2) { FactoryBot.create(:task, user_id: @user.id, title: "task2 title", detail: "task2 detail", status: "not started") }
    context 'Title is performed by scope method' do
      it "Tasks containing search keywords are narrowed down" do
        # title_seach is a Title search method presented by scope. The method name can be arbitrary.
        expect(Task.title_search('task1')).to include(task1)
        expect(Task.title_search('task1')).not_to include(task2)
        expect(Task.title_search('task1').count).to eq 1
      end
    end
    context 'When the status is searched with the scope method' do
      it "Tasks that exactly match the status are narrowed down" do
        expect(Task.status_search('started')).to include(task1)
        expect(Task.status_search('started')).not_to include(task2)
        expect(Task.status_search('started').count).to eq 1
      end
    end
    context 'When performing fuzzy search and status search Title' do
      it "Narrow down tasks that include search keywords in the Title and exactly match the status" do
        expect(Task.title_search('task1').status_search('started')).to include(task1)
      end
    end
  end
end
