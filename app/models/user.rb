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
class User < ApplicationRecord

  # == Extensions ===========================================================
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  # == Constants ============================================================
  USER_TYPES = %w[Admin Doctor Patient].freeze

  # == Attributes ===========================================================

  # == Relationships ========================================================

  # == Validations ==========================================================
  validates :phone, presence: true, uniqueness: true, format: { with: /\d{10}/ }

  # == Scopes ===============================================================
  scope :order_by_email, -> { order(:email) }

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  USER_TYPES.each do |user_type|
    define_method(:"#{user_type.downcase}?") do
      type == user_type
    end
  end

end
