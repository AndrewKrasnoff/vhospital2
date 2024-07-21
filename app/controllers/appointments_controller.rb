class AppointmentsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    render :index, locals: { appointments: }
  end

  def show
    render :show, locals: { appointment: }
  end

  def new
    if patient_has_appointment?
      redirect_to appointments_path, flash: { alert: I18n.t('flash_messages.appointments.assigned') }
    elsif doctor.unavailable?
      redirect_to category_path(doctor.category_id), flash: { alert: I18n.t('flash_messages.appointments.has_ten') }
    else
      render :new, locals: { appointment:, doctor: }
    end
  end

  def edit
    if appointment.answer.nil?
      render :edit, locals: { appointment: }
    else
      redirect_to appointment_path(appointment), flash: { alert: I18n.t('flash_messages.appointments.closed') }
    end
  end

  def create
    if appointment.save
      Appointments::NotificationSender.call(appointment, current_user)
      redirect_to appointments_path, flash: { success: I18n.t('flash_messages.appointments.created') }
    else
      flash.now[:danger] = I18n.t('flash_messages.appointments.not_created')
      render :new, locals: { appointment:, doctor: }
    end
  end

  def update
    if appointment.update(appointment_params)
      Appointments::NotificationSender.call(appointment, current_user)
      redirect_to appointments_path, flash: { success: I18n.t('flash_messages.appointments.answer_published') }
    else
      flash.now[:danger] = I18n.t('flash_messages.appointments.answer_not_published')
      render :edit
    end
  end

  private

  def appointment
    @appointment ||= Appointment.find(params[:id])
  end

  def doctor
    doctor_id = params[:doctor_id] || appointment_params[:doctor_id]

    Doctor.find(doctor_id)
  end

  def appointment_params
    if action_name == 'new' || action_name == 'create'
      params.require(:appointment).permit(:patient_id, :doctor_id, :question, :priority)
    else
      params.require(:appointment).permit(:answer)
    end
  end

  def patient_has_appointment?
    Appointment.opened.exists?(patient_id: current_user.id, doctor_id: doctor.id)
  end

  def appointments
    return if current_user.admin?

    current_user.appointments
  end

end
