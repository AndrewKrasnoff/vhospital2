# == Schema Information
#
# Table name: users
#
#  id                  :uuid             not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  role                :integer
#  phone               :string(10)
#  category_id         :uuid
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'rails_helper'

RSpec.describe User do
  describe 'enums' do
    it { is_expected.to define_enum_for(:role).with_values(admin: 0, patient: 1, doctor: 2) }
  end

  describe 'associations' do
    let!(:user) { build(:user) }

    it do
      expect(user).to have_many(:doctor_appointments).class_name('Appointment')
                                                     .inverse_of('doctor')
                                                     .dependent(:destroy)

      expect(user).to have_many(:patient_appointments).class_name('Appointment')
                                                      .inverse_of('patient')
                                                      .dependent(:destroy)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_uniqueness_of(:phone) }

    describe 'validation of category presence' do
      context 'when user role is not "Dcoctor"' do
        let!(:patient) { build(:user, role: :patient) }
        let!(:admin)   { build(:user, role: :admin) }

        it 'is valid' do
          expect(patient).to be_valid
          expect(admin).to be_valid
        end
      end

      context 'when user role is "Dcoctor"' do
        context 'when category is nil' do
          let!(:doctor) { build(:user, role: :doctor, category: nil) }

          it 'is not valid' do
            expect(doctor).not_to be_valid
          end
        end

        context 'when category is not nil' do
          let!(:category) { create(:category) }
          let!(:doctor)   { build(:user, role: :doctor) }

          it 'is valid' do
            doctor.category = category

            expect(doctor).to be_valid
          end
        end
      end
    end
  end

  describe 'instance methods' do
    describe '#available?' do
      context 'when user role is "Admin"' do
        let!(:user) { build(:user, role: :admin) }

        it 'returns TRUE' do
          expect(user.available?).to be true
        end
      end

      context 'when user role is "Patient"' do
        let!(:user) { build(:user, role: :patient) }

        it 'returns TRUE' do
          expect(user.available?).to be true
        end
      end

      context 'when user role is "Doctor"' do
        context 'when doctor has more than 10 active (without answer) appointments' do
          let!(:doctor) { create(:user, role: :doctor) }

          before do
            create_list(:appointment, 8, doctor:)
            create_list(:appointment, 4, doctor:)
            create_list(:appointment, 4, :with_answer, doctor:)
          end

          it 'returns FALSE' do
            expect(doctor.available?).to be false
          end
        end

        context 'when has 10 active (without answer) appointments' do
          let!(:doctor) { create(:user, role: :doctor) }

          before do
            create_list(:appointment, 10, doctor:)
            create_list(:appointment, 4, :with_answer, doctor:)
          end

          it 'returns FALSE' do
            expect(doctor.available?).to be false
          end
        end

        context 'when has laees than 10 active (without answer) appointments' do
          let!(:doctor) { create(:user, role: :doctor) }

          before do
            create_list(:appointment, 8, doctor:)
            create_list(:appointment, 4, :with_answer, doctor:)
          end

          it 'returns TRUE' do
            expect(doctor.available?).to be true
          end
        end
      end
    end
  end
end
