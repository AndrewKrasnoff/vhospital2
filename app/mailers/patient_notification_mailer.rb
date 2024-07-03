class PatientNotificationMailer < ApplicationMailer

  def email(appointment)
    @appointment = appointment
    @recipient   = appointment.patient.email

    mail(to: @recipient, subject: I18n.t('emial.subjects.new_appoinment'))
  end

end
