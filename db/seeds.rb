User.create!(name: "Seed1", email: "seed1@example.com", password: "password", is_admin: true)
Task.create!(title: "title task1", detail: "detail task1", status: "started", priority: "high", deadline: "2022-02-01", user_id: User.first.id)
