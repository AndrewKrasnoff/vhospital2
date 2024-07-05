class DoctorNotificationMailerPreview < ActionMailer::Preview

  def email
    DoctorNotificationMailer.email(Appointment.first)
  end

end
