module Appointments

  class NotificationSender < ApplicationService

    def initialize(appointment, user)
      @appointment = appointment
      @user        = user
    end

    def call
      send_notification_to_patient if user.doctor?
      send_notification_to_doctor if user.patient?
    end

    private

    attr_reader :appointment, :user

    def send_notification_to_patient
      PatientNotificationMailer.email(appointment).deliver_later
    end

    def send_notification_to_doctor
      DoctorNotificationMailer.email(appointment).deliver_later
    end

  end

end
