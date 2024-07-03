require 'rails_helper'

RSpec.describe PatientNotificationMailer do
  subject(:mail) { described_class.email(appointment) }

  let!(:doctor) { create(:doctor) }
  let!(:patient) { create(:patient) }
  let!(:appointment) { create(:appointment, doctor:, patient:) }

  describe '#email' do
    describe 'metadata' do
      it 'sends email to the patient' do
        expect(mail.to).to eq([patient.email])
      end

      it "has recipient's name" do
        expect(mail.body).to include(doctor.email)
      end

      it 'has a link to site' do
        expect(mail.body).to include(ENV.fetch('APP_URL', 'http://localhost:3000/'))
      end
    end
  end
end
