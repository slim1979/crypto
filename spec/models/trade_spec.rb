require 'rails_helper'

RSpec.describe Trade, type: :model do
  it { should belong_to :pair }
  it { should validate_presence_of :trade_id }
  it { should validate_presence_of :price }
  it { should validate_presence_of :quantity }
  it { should validate_presence_of :side }
  it { should validate_presence_of :timestamp }
  it { should validate_uniqueness_of :trade_id }

end
