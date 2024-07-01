# == Schema Information
#
# Table name: categories
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  # == Extensions ===========================================================

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Relationships ========================================================
  has_many :users, dependent: :nullify

  # == Validations ==========================================================
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # == Scopes ===============================================================
  scope :order_by_name, -> { order(:name) }

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
end
