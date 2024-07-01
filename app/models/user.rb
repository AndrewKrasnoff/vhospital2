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
class User < ApplicationRecord
  # == Extensions ===========================================================
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  enum role: { admin: 0, patient: 1, doctor: 2 }

  # == Constants ============================================================
  MAX_OPEN_APPOINTMENTS = 10

  # == Attributes ===========================================================

  # == Relationships ========================================================
  with_options dependent: :destroy do
    has_many :doctor_appointments,  class_name: 'Appointment', foreign_key: 'doctor_id', inverse_of: 'doctor'
    has_many :patient_appointments, class_name: 'Appointment', foreign_key: 'patient_id', inverse_of: 'patient'
  end

  belongs_to :category, optional: true

  # == Validations ==========================================================
  validates :phone,    presence: true, uniqueness: true, format: { with: /\d{10}/ }
  validates :category, presence: true, if: proc { |u| u.doctor? }

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def unavailable?
    return false unless doctor?

    doctor_appointments.opened.count >= MAX_OPEN_APPOINTMENTS
  end
end
