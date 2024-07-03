# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    admin_access if user.admin?
    patient_access if user.patient?
    doctor_access if user.doctor?
  end

  private

  def admin_access
    can :manage, Category
    can %i[index show update], Doctor
    can :read, Patient
  end

  def patient_access
    can [:show], Category
    can %i[index show new create], Appointment
  end

  def doctor_access
    can %i[index show update], Appointment
  end
end
