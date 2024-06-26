class PatientsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: false

  def index
    @patients = User.where(role: :patient).order(:email)
  end
end
