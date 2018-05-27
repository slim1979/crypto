require 'rails_helper'

RSpec.describe PairsController, type: :controller do

  let(:pair)   { create(:pair) }
  let(:pairs) { create_list(:pair, 6) }
  let(:candles) { create_list(:candle, 6, pair: pair) }

  describe 'GET #index' do
    before { get :index }

    it 'populates an array of all pairs' do
      expect(assigns(:pairs)).to match_array(pairs)
    end

    it 'will render index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: pair } }

    it 'assign request pair to @pair' do
      expect(assigns(:pair)).to eq pair
    end

    it 'renders show template' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #candles' do
    before { get :candles, params: { id: pair } }

    it 'assign request pair to @pair' do
      expect(assigns(:pair)).to eq pair
      expect(assigns(:candles)).to match_array(candles)
    end

    it 'will render history template' do
      expect(response).to render_template :candles
    end
  end
end
