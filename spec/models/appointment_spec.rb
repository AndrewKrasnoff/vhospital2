# == Schema Information
#
# Table name: appointments
#
#  id         :uuid             not null, primary key
#  doctor_id  :uuid             not null
#  patient_id :uuid             not null
#  question   :text
#  answer     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Appointment do
  describe 'constants' do
    it { expect(Appointment::PENDING).to eq('PENDING') }
    it { expect(Appointment::CLOSED).to eq('CLOSED') }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:doctor) }
    it { is_expected.to belong_to(:patient) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:question) }

    describe 'validation of answer presence' do
      context 'when apponiment is new (just create by patient)' do
        let!(:appointment) { build(:appointment) }

        it 'is valid' do
          expect(appointment).to be_valid
        end
      end

      context 'when apponiment is not new' do
        let!(:appointment) { create(:appointment) }

        it 'is not valid' do
          expect(appointment).not_to be_valid
        end
      end
    end
  end

  describe 'scopes' do
    describe '.opened' do
      let!(:appointment) { create(:appointment) }

      before { create(:appointment, :with_answer) }

      it 'returns appointmens with answers' do
        expect(described_class.opened).to eq([appointment])
      end
    end
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
