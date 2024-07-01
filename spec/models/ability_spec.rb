require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability do
  subject(:ability) { described_class.new(user) }

  context 'when there is no user' do
    let(:user)  { nil }

    it { is_expected.not_to be_able_to(:manage, User) }
    it { is_expected.not_to be_able_to(:manage, Appointment) }
    it { is_expected.not_to be_able_to(:manage, Category) }
  end

  context 'when user is Admin' do
    let(:user)  { create(:user, role: :admin) }

    it { is_expected.to be_able_to(:manage, Category) }
    it { is_expected.not_to be_able_to(:manage, Appointment) }

    it { is_expected.to be_able_to(:index, :doctor) }
    it { is_expected.to be_able_to(:show, :doctor) }
    it { is_expected.to be_able_to(:update, :doctor) }
    it { is_expected.not_to be_able_to(:new, :doctor) }
    it { is_expected.not_to be_able_to(:create, :doctor) }
  end
end
