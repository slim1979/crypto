class PairsController < ApplicationController
  before_action :load_pair, except: :index

  def index
    @pairs = Pair.all
  end

  def show; end

  def history; end

  private

  def load_pair
    @pair = Pair.find params[:id]
  end
end
