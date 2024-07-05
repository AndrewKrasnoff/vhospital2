class PatientNotificationMailerPreview < ActionMailer::Preview

  def email
    PatientNotificationMailer.email(Appointment.first)
  end

end
