require 'acceptance_helper'

feature 'User can see pair trades info', %q(
  In order to see pair trades info
  As an user
  I want to be able to choose Trades
) do

  let!(:pair) { create(:pair) }
  let!(:trades) { create_list(:trade, 6, pair: pair) }

  scenario 'click on \'Trades\' will show trades detail' do
    visit pairs_path
    click_on pair.symbols
    click_on 'Trades'
    trades.each do |trade|
      expect(page).to have_content trade.trade_id
      expect(page).to have_content trade.price
      expect(page).to have_content trade.quantity
      expect(page).to have_content trade.side
      expect(page).to have_content trade.timestamp
    end
  end
end
