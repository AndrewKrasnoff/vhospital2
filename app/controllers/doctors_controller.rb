class DoctorsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: false

  def index
    render :index, locals: { doctors: }
  end

  def edit
    render :edit, locals: { doctor: }
  end

  def update
    if doctor.update(doctor_params)
      redirect_to doctors_path, success: I18n.t('flash_messages.categories.updated')
    else
      flash.now[:danger] = I18n.t('flash_messages.categories.not_updated')
      render :edit, locals: { doctor: }
    end
  end

  private

  def doctor
    @doctor = User.find(params[:id])
  end

  def doctors
    User.where(role: :doctor).includes(:category).order('categories.name', :email)
  end

  def doctor_params
    params.require(:user).permit(:category_id)
  end
end
