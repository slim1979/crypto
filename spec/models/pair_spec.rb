require 'rails_helper'

RSpec.describe Pair, type: :model do
  it { should validate_presence_of :symbols }
  it { should validate_presence_of :baseCurrency }
  it { should validate_presence_of :quoteCurrency }
  it { should validate_presence_of :quantityIncrement }
  it { should validate_presence_of :tickSize }
  it { should validate_presence_of :takeLiquidityRate }
  it { should validate_presence_of :provideLiquidityRate }
  it { should validate_presence_of :feeCurrency }
  it { should have_many :candles }
  it { should have_many :trades }
end
