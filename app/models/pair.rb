class Pair < ApplicationRecord
  has_many :trades, dependent: :destroy
  has_many :candles, dependent: :destroy
  has_one :orderbook, dependent: :destroy
  validates :symbols,
            :baseCurrency,
            :quoteCurrency,
            :quantityIncrement,
            :tickSize,
            :takeLiquidityRate,
            :provideLiquidityRate,
            :feeCurrency,
            presence: true
  validates :symbols, uniqueness: true

  class << self
    def check_shedule
      check_for_new_pairs if need_update?('pair')
      check_for_trades if need_update?('trade')
      check_for_candles if need_update?('candle')
    end

    def need_update?(type)
      type = type.capitalize.constantize
      type.count < 1 || (Time.now - type.pluck(:created_at).max) / 84_600 > 1
    end

    def check_for_new_pairs
      request('symbol').each do |pair_params|
        Pair.create(symbols: pair_params['id'],
                    baseCurrency: pair_params['baseCurrency'],
                    quoteCurrency: pair_params['quoteCurrency'],
                    quantityIncrement: pair_params['quantityIncrement'],
                    tickSize: pair_params['tickSize'],
                    takeLiquidityRate: pair_params['takeLiquidityRate'],
                    provideLiquidityRate: pair_params['provideLiquidityRate'],
                    feeCurrency: pair_params['feeCurrency'])
      end
    end

    def check_for_trades
      Pair.all.each do |pair|
        request("trades/#{pair.symbols}").each do |trade_params|
          pair.trades.create(trade_id: trade_params['id'],
                             price: trade_params['price'],
                             quantity: trade_params['quantity'],
                             side: trade_params['side'],
                             timestamp: trade_params['timestamp'])
        end
      end
    end

    def check_for_candles
      Pair.all.each do |pair|
        request("candles/#{pair.symbols}").each do |trade_params|
          pair.candles.create(timestamp: trade_params['timestamp'],
                              open: trade_params['open'],
                              close: trade_params['close'],
                              min: trade_params['min'],
                              max: trade_params['max'],
                              volume: trade_params['volume'],
                              volumeQuote: trade_params['volumeQuote'])
        end
      end
    end

    private

    def request(path)
      url = URI("https://api.hitbtc.com/api/2/public/#{path}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)

      response = http.request(request)
      JSON.parse(response.read_body)
    end
  end
end
