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
    let!(:pair) { create(:pair, created_at: Time.current.localtime.yesterday.beginning_of_day ) }
    let!(:trade) { create(:trade, pair: pair) }

    it 'will check for new pair' do
      expect(Pair).to receive('check_for_new_pairs').and_return(Array) if Pair.count < 1 || (Time.now - pair.created_at)/84600 > 1
      expect(Pair).to receive('check_for_new_trades').and_return(Array) if (Time.now - Trade.last.created_at) / 84_600 > 1
      Pair.check_shedule
    end
  end
end
