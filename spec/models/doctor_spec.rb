# == Schema Information
#
# Table name: users
#
#  id                  :uuid             not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  type                :string
#  phone               :string(10)
#  category_id         :uuid
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'rails_helper'

RSpec.describe Doctor do
  describe 'constants' do
    it { expect(Doctor::MAX_OPENED_APPOINTMENTS).to eq(10) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:appointments).dependent(:destroy) }
    it { is_expected.to have_many(:patients).through(:appointments) }
  end

  describe 'instance methods' do
    describe '#unavailable?' do
      context 'when doctor has more than 10 active (without answer) appointments' do
        let!(:doctor) { create(:doctor) }

        before do
          create_list(:appointment, 8, doctor:)
          create_list(:appointment, 4, doctor:)
          create_list(:appointment, 4, :with_answer, doctor:)
        end

        it 'returns TRUE' do
          expect(doctor.unavailable?).to be true
        end
      end

      context 'when has 10 active (without answer) appointments' do
        let!(:doctor) { create(:doctor) }

        before do
          create_list(:appointment, 10, doctor:)
          create_list(:appointment, 4, :with_answer, doctor:)
        end

        it 'returns TRUE' do
          expect(doctor.unavailable?).to be true
        end
      end

      context 'when has laees than 10 active (without answer) appointments' do
        let!(:doctor) { create(:doctor) }

        before do
          create_list(:appointment, 8, doctor:)
          create_list(:appointment, 4, :with_answer, doctor:)
        end

        it 'returns FALSE' do
          expect(doctor.unavailable?).to be false
        end
      end
    end
  end
end
