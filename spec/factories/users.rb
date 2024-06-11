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
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :user do
    user_type { :patient }
    phone     { '1234567890' }
  end
end
