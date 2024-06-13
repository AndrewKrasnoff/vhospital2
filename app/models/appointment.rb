# == Schema Information
#
# Table name: appointments
#
#  id         :uuid             not null, primary key
#  doctor_id  :uuid
#  patient_id :uuid
#  question   :text
#  answer     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Appointment < ApplicationRecord
  # == Extensions ===========================================================

  # == Constants ============================================================
  PENDING = 'PENDING'.freeze
  CLOSED  = 'CLOSED'.freeze

  # == Attributes ===========================================================

  # == Relationships ========================================================
  belongs_to :doctor
  belongs_to :patient

  # == Validations ==========================================================
  validates :question, presence: true
  validates :answer,   presence: true, if: :should_validate?

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  def short_id
    "#{id[0..4]}...#{id[-5..]}"
  end

  private

  def should_validate?
    !new_record?
  end
end
