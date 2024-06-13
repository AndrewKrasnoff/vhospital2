# == Schema Information
#
# Table name: appointments
#
#  id         :uuid             not null, primary key
#  doctor_id  :uuid
#  patient_id :uuid
#  question   :text
#  answer     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Appointment do
  describe 'associations' do
    it { is_expected.to belong_to(:doctor) }
    it { is_expected.to belong_to(:patient) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:question) }
  end

  describe 'instance methods' do
    describe '#short_id' do
      let!(:appointment) { create(:appointment) }

      it 'returns first five characters and last five characters of ID' do
        expected_result = "#{appointment.id[0..4]}...#{appointment.id[-5..]}"
        result = appointment.short_id

        expect(result).to eq(expected_result)
      end
    end
  end
end
