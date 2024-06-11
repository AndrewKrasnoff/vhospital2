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
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  enum user_type: { admin: 0, patient: 1, doctor: 2 }

  validates :phone, presence: true, uniqueness: true, format: { with: /\d{10}/ }
end
