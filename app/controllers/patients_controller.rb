class PatientsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    render :index, locals: { patients: }
  end

  private

  def patients
    Patient.order_by_email
  end
end
