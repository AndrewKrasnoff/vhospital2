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
  describe 'constants' do
    it { expect(User::USER_TYPES).to eq(%w[Admin Doctor Patient]) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_uniqueness_of(:phone) }
  end

  describe 'instance methods' do
    describe '#admin?' do
      context 'when user type is Admin' do
        let!(:user) { build(:admin) }

        it { expect(user).to be_admin }
      end

      context 'when user type is not Admin' do
        let!(:user) { build(:patient) }

        it { expect(user).not_to be_admin }
      end
    end

    describe '#doctor?' do
      context 'when user type is Doctor' do
        let!(:user) { build(:doctor) }

        it { expect(user).to be_doctor }
      end

      context 'when user type is not Doctor' do
        let!(:user) { build(:patient) }

        it { expect(user).not_to be_doctor }
      end
    end

    describe '#patient?' do
      context 'when user type is Patient' do
        let!(:user) { build(:patient) }

        it { expect(user).to be_patient }
      end

      context 'when user type is not Patient' do
        let!(:user) { build(:admin) }

        it { expect(user).not_to be_patient }
      end
    end
  end
end
