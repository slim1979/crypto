class PairsController < ApplicationController
  def index
    @pairs = Pair.all
  end

  def show
    @pair = Pair.find params[:id]
  end
end
