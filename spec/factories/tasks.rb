FactoryBot.define do
  factory :task do
    title { 'test_title1' }
    detail { 'test_detail1' }
  end
  factory :secon_task do
    title { 'test_title2' }
    detail { 'test_detail2' }
  end
end
