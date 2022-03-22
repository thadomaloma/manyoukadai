FactoryBot.define do
  factory :admin_user do
    name { "admin user" }
    email { "admin_user@example.com" }
    password_digest { "password" }
    is_admin { true }
  end
  
  factory :user, class: User do
    name { "user" }
    email { "user@example.com" }
    password_digest { "password" }
    is_admin { false }
  end
end
