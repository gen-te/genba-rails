FactoryBot.define do
    factory :task do
        name {'タスクを書く'}
        description {'RSpec & Capybara & FactoryBotを準備する'}
        user
    end
end