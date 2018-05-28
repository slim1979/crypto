require 'acceptance_helper'

feature 'User can see pair orderbook', %q(
  In order to see pair orderbook
  As an user
  I want to be able to choose orderbook details
) do

  let!(:pair) { create(:pair) }
  let!(:orderbook_asks) { create_list(:orderbook_ask, 3, pair: pair) }
  let!(:orderbook_bids) { create_list(:orderbook_bid, 3, pair: pair) }

  scenario 'User can see pair orderbook link' do
    visit pairs_path
    click_on pair.symbols

    expect(page).to have_link 'Orderbook'
  end

  scenario 'User can see pair orderbook' do
    visit pairs_path
    click_on pair.symbols
    click_on 'Orderbook'

    %w[orderbook_asks orderbook_bids].each do |kind|
      send(kind.to_s).each do |type|
        expect(page).to have_content type['price']
        expect(page).to have_content type['size']
      end
    end
  end
end
