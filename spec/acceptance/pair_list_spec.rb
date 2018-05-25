require 'acceptance_helper'

feature 'User can see pairs list', %q(
  In order to choose pair
  As an user
  I want to see pairs list
) do

  let!(:pairs) { create_list(:pair, 6) }

  scenario 'page contain pairs' do
    visit pairs_path
    pairs.each do |pair|
      within ".#{pair.symbols}" do
        expect(page).to have_content pair.symbols
        expect(page).to have_content pair.baseCurrency
        expect(page).to have_content pair.quoteCurrency
        expect(page).to have_content pair.quantityIncrement
        expect(page).to have_content pair.tickSize
        expect(page).to have_content pair.takeLiquidityRate
        expect(page).to have_content pair.provideLiquidityRate
        expect(page).to have_content pair.feeCurrency
      end
    end
  end
end
