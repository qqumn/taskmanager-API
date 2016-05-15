require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.updated_today' do
    let!(:updated_yesterday) { create(:user, updated_at: Date.today - 1.day) }
    let!(:updated_today) { create(:user) }

    subject { described_class.updated_today }

    it { is_expected.to include(updated_today) }
    it { is_expected.not_to include(updated_yesterday)  }
  end
end
