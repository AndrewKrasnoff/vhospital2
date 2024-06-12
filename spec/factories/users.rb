# == Schema Information
#
# Table name: users
#
#  id                  :uuid             not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  type                :string
#  phone               :string(10)
#  category_id         :uuid
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :user do
    transient do
      category { association :category }
    end

    email                 { Faker::Internet.email }
    type                  { %w[Admin Patient Doctor].sample }
    phone                 { Faker::Number.number(digits: 10).to_s }
    password              { 'password' }
    password_confirmation { 'password' }

    after(:create) do |user, evaluator|
      user.update(category: evaluator.category) if user.type == 'Doctor'
    end
  end
end
