require 'rails_helper'

RSpec.describe Pair, type: :model do
  it { should validate_presence_of :symbols }
  it { should have_many :candles }
  it { should have_many :trades }
end
