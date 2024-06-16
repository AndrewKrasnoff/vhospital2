# == Schema Information
#
# Table name: users
#
#  id                  :uuid             not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  role                :integer
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
    role                  { User.roles.to_a.sample[1] }
    phone                 { Faker::Number.number(digits: 10).to_s }
    password              { 'password' }
    password_confirmation { 'password' }

    before(:create) do |user, evaluator|
      user.update(category: evaluator.category) if user.doctor?
    end
  end
end
