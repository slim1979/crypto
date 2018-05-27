require 'rails_helper'

RSpec.describe Orderbook, type: :model do
  it { should belong_to :pair }
  it { should validate_presence_of :ask }
  it { should validate_presence_of :bid }
end
