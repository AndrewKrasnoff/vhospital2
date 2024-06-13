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
  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:appointments).dependent(:nullify) }
  end

  describe 'instance methods' do
    describe '#available?' do
      context 'when doctor has more than 10 opened (without answer) appointments' do
        let!(:doctor) { create(:doctor) }

        before { create_list(:appointment, 15, doctor:) }

        it 'returns FALSE' do
          expect(doctor.available?).to be false
        end
      end

      context 'when doctor has 10 opened (without answer) appointments' do
        let!(:doctor) { create(:doctor) }

        before { create_list(:appointment, 10, doctor:) }

        it 'returns FALSE' do
          expect(doctor.available?).to be false
        end
      end

      context 'when doctor has less than 10 opened (without answer) appointments' do
        let!(:doctor) { create(:doctor) }

        before { create_list(:appointment, 8, doctor:) }

        it 'returns TRUE' do
          expect(doctor.available?).to be true
        end
      end
    end
  end
end
