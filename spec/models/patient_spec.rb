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

RSpec.describe Patient do
  describe 'associations' do
    it { is_expected.to have_many(:appointments).dependent(:destroy) }
    it { is_expected.to have_many(:doctors).through(:appointments) }
  end
end
