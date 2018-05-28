class Pair < ApplicationRecord
  has_many :trades, dependent: :destroy
  has_many :candles, dependent: :destroy
  has_many :orderbook_asks, dependent: :destroy
  has_many :orderbook_bids, dependent: :destroy
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
      check_for_new_pairs if need_update?('Pair')
      check_for_trades if need_update?('Trade')
      check_for_orderbook if need_update?('Orderbook')
      check_for_candles if need_update?('Candle')
    end

    private

    def need_update?(type)
      return orderbook_update if type == 'Orderbook'
      type = type.constantize
      type.count < 1 || (Time.now - type.pluck(:created_at).max) / 84_600 > 1
    end

    def orderbook_update
      [OrderbookAsk, OrderbookBid].each { |kind| kind.count < 1 || (Time.now - kind.pluck(:created_at).max) / 84_600 > 1 }
    end

    def check_for_new_pairs
      request('symbol').each do |params|
        Pair.create(symbols: params['id'],
                    baseCurrency: params['baseCurrency'],
                    quoteCurrency: params['quoteCurrency'],
                    quantityIncrement: params['quantityIncrement'],
                    tickSize: params['tickSize'],
                    takeLiquidityRate: params['takeLiquidityRate'],
                    provideLiquidityRate: params['provideLiquidityRate'],
                    feeCurrency: params['feeCurrency'])
      end
    end

    def check_for_trades
      Pair.all.each do |pair|
        request("trades/#{pair.symbols}").each do |params|
          pair.trades.create(trade_id: params['id'],
                             price: params['price'],
                             quantity: params['quantity'],
                             side: params['side'],
                             timestamp: params['timestamp'])
        end
      end
    end

    def check_for_orderbook
      Pair.all.each do |pair|
        orderbook = request("orderbook/#{pair.symbols}")
        create_orderbook('ask', pair, orderbook)
        create_orderbook('bid', pair, orderbook)
      end
    end

    def create_orderbook(type, pair, orderbook)
      orderbook[type.to_s].each do |kind|
        pair.send("orderbook_#{type}s").create(price: kind['price'],
                                               size: kind['size'])
      end
    end

    def check_for_candles
      Pair.all.each do |pair|
        request("candles/#{pair.symbols}").each do |params|
          pair.candles.create(timestamp: params['timestamp'],
                              open: params['open'],
                              close: params['close'],
                              min: params['min'],
                              max: params['max'],
                              volume: params['volume'],
                              volumeQuote: params['volumeQuote'])
        end
      end
    end

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
