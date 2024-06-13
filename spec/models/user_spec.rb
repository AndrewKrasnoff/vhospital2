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

RSpec.describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_uniqueness_of(:phone) }
  end

  describe 'instance methods' do
    describe '#doctor?' do
      context 'when user type is "Doctor"' do
        let!(:user) { build(:user, type: 'Doctor') }

        it 'returns TRUE' do
          expect(user.doctor?).to be true
        end
      end

      context 'when user type is NOT "Doctor"' do
        let!(:user) { build(:user, type: 'AnyType') }

        it 'returns FALSE' do
          expect(user.doctor?).to be false
        end
      end
    end

    describe '#patient?' do
      context 'when user type is "Patient"' do
        let!(:user) { build(:user, type: 'Patient') }

        it 'returns TRUE' do
          expect(user.patient?).to be true
        end
      end

      context 'when user type is NOT "Patient"' do
        let!(:user) { build(:user, type: 'AnyType') }

        it 'returns FALSE' do
          expect(user.patient?).to be false
        end
      end
    end

    describe '#admin?' do
      context 'when user type is "Admin"' do
        let!(:user) { build(:user, type: 'Admin') }

        it 'returns TRUE' do
          expect(user.admin?).to be true
        end
      end

      context 'when user type is NOT "Patient"' do
        let!(:user) { build(:user, type: 'AnyType') }

        it 'returns FALSE' do
          expect(user.admin?).to be false
        end
      end
    end
  end
end
