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
  it { should have_many(:candles).dependent(:destroy) }
  it { should have_many(:trades).dependent(:destroy) }
  it { should have_one(:orderbook).dependent(:destroy) }
  it { should validate_uniqueness_of :symbols }

  describe 'daily check for new pairs' do
    let(:pair)   { create(:pair, created_at: Time.current.localtime.yesterday.beginning_of_day ) }
    let(:trade)  { create(:trade, pair: pair) }
    let(:candle) { create(:candle, pair: pair) }

    it 'will check for new pair' do
      expect(Pair).to receive('check_for_new_pairs').and_return(Array)
      expect(Pair).to receive('check_for_trades').and_return(Array)
      expect(Pair).to receive('check_for_candles').and_return(Array)
      Pair.check_shedule
    end
  end
end
