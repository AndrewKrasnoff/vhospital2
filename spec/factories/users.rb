# == Schema Information
#
# Table name: users
#
#  id                  :uuid             not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  user_type           :integer
#  phone               :string(10)
#  category_id         :uuid
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.email }
    user_type             { User.user_types.to_a.sample[0] }
    phone                 { Faker::Number.number(digits: 10).to_s }
    password              { 'password' }
    password_confirmation { 'password' }
  end
end
