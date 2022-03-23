# User
User.create!(name: "Admin", email: "Admin@example.com", password: "password", is_admin: true)
10.times do |n|
	User.create!(name: "User#{n+1}", email: "user#{n+1}@example.com", password: "password")
end


# Label
10.times do |n|
	Label.create!(name: "Label#{n+1}", user_id: User.first.id)
end

# Task
Task.create!(title: "title task1", detail: "detail task1", status: "started", priority: "high", deadline: "2022-02-01", user_id: User.first.id, label_ids: Label.first.id)
Task.create!(title: "title task2", detail: "detail task2", status: "not started", priority: "middle", deadline: "2022-02-04", user_id: User.first.id, label_ids: Label.first.id)
Task.create!(title: "title task3", detail: "detail task3", status: "not started", priority: "high", deadline: "2022-02-06", user_id: User.second.id, label_ids: Label.second.id)
Task.create!(title: "title task4", detail: "detail task4", status: "not started", priority: "low", deadline: "2022-02-10", user_id: User.third.id, label_ids: Label.third.id)
Task.create!(title: "title task5", detail: "detail task5", status: "started", priority: "middle", deadline: "2022-02-05", user_id: User.fourth.id, label_ids: Label.fourth.id)
Task.create!(title: "title task6", detail: "detail task6", status: "started", priority: "high", deadline: "2022-02-03", user_id: User.fifth.id, label_ids: Label.fifth.id)
Task.create!(title: "title task7", detail: "detail task7", status: "started", priority: "low", deadline: "2022-02-07", user_id: User.first.id, label_ids: Label.last.id)
Task.create!(title: "title task8", detail: "detail task8", status: "completed", priority: "middle", deadline: "2022-02-01", user_id: User.last.id, label_ids: Label.last.id)
Task.create!(title: "title task9", detail: "detail task9", status: "completed", priority: "high", deadline: "2022-02-02", user_id: User.last.id, label_ids: Label.first.id)
Task.create!(title: "title task10", detail: "detail task10", status: "completed", priority: "low", deadline: "2022-02-09", user_id: User.last.id, label_ids: Label.third.id)
Task.create!(title: "title task11", detail: "detail task11", status: "not started", priority: "middle", deadline: "2022-03-01", user_id: User.first.id, label_ids: Label.second.id)
Task.create!(title: "title task12", detail: "detail task12", status: "completed", priority: "high", deadline: "2022-01-02", user_id: User.first.id, label_ids: Label.last.id)
Task.create!(title: "title task13", detail: "detail task13", status: "started", priority: "low", deadline: "2022-02-09", user_id: User.first.id, label_ids: Label.first.id)
