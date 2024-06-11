# == Schema Information
#
# Table name: users
#
#  id                  :uuid             not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  user_type           :integer
#  phone               :string(10)
#  category_id         :uuid
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'rails_helper'

RSpec.describe User do
  describe 'enums' do
    it { is_expected.to define_enum_for(:user_type).with_values(admin: 0, patient: 1, doctor: 2) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:category).optional }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_uniqueness_of(:phone) }
  end
end
