require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'assosiations' do
    it { is_expected.to belong_to(:commentable) }
    it { is_expected.to belong_to(:user) }
  end
end
