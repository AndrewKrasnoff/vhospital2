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
class User < ApplicationRecord
  # == Extensions ===========================================================
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  enum user_type: { admin: 0, patient: 1, doctor: 2 }

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Relationships ========================================================
  belongs_to :category, optional: true

  # == Validations ==========================================================
  validates :phone, presence: true, uniqueness: true, format: { with: /\d{10}/ }

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
