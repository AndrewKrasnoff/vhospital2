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
class Doctor < User
  # == Extensions ===========================================================

  # == Constants ============================================================
  MAX_OPENED_APPOINTMENTS = 10

  # == Attributes ===========================================================

  # == Relationships ========================================================
  belongs_to :category
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def unavailable?
    appointments.opened.count >= MAX_OPENED_APPOINTMENTS
  end
end
