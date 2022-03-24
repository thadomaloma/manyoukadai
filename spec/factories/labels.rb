FactoryBot.define do
  factory :label do
    name { "label1" }
    user_id { User.first.id }
  end
  factory :second_lable do
    name { "label2" }
    user_id { User.first.id }
  end
end
