require 'acceptance_helper'

feature 'User can see pairs list', %q(
  In order to choose pair
  As an user
  I want to see pairs list
) do

  let!(:pairs)  { create_list(:pair, 6) }
  let!(:candles) { create_list(:candle, 6, pair: pairs.first) }

  describe 'User sees, that' do
    before { visit pairs_path }

    scenario 'pair row contain pair attributes, links to pair details and to pair candles' do
      pairs.each do |pair|
        within ".#{pair.symbols}" do
          expect(page).to have_link pair.symbols
          expect(page).to have_content pair.baseCurrency
          expect(page).to have_content pair.quoteCurrency
          expect(page).to have_content pair.quantityIncrement
          expect(page).to have_content pair.tickSize
          expect(page).to have_content pair.takeLiquidityRate
          expect(page).to have_content pair.provideLiquidityRate
          expect(page).to have_content pair.feeCurrency
          expect(page).to have_link 'История торгов'
        end
      end
    end

    scenario 'click on pair symbols will show pair detail', js: true do
      click_on pairs.first.symbols
      expect(page).to have_content "Валютная пара #{pairs.first.symbols}"
      expect(page).to have_link 'Trades'
      expect(page).to have_link 'Orderbook'
    end

    scenario 'click on \'История торгов\' will show pair candles info' do
      within ".#{pairs.first.symbols}" do
        click_on 'История торгов'
      end
      expect(page).to have_content "История торгов валютной пары #{pairs.first.symbols}"
      candles.each do |candle|
        expect(page).to have_content candle.timestamp
        expect(page).to have_content candle.open
        expect(page).to have_content candle.close
        expect(page).to have_content candle.min
        expect(page).to have_content candle.max
        expect(page).to have_content candle.volume
        expect(page).to have_content candle.volumeQuote
      end
    end
  end
end
