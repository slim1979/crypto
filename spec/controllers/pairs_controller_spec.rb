require 'rails_helper'

RSpec.describe PairsController, type: :controller do

  let(:pairs) { create_list(:pair, 6) }

  describe 'GET #index' do
    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:pairs)).to match_array(pairs)
    end

    it 'will render index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: pairs.first } }

    it 'assign request pair to @pair' do
      expect(assigns(:pair)).to eq pairs.first
    end

    it 'renders show template' do
      expect(response).to render_template :show
    end
  end
end
