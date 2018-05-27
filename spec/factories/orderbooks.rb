FactoryBot.define do
  sequence :array do
    Array.new(6) { |_i| { 'price' => rand(0.000_001..0.001).round(6), 'size' => rand(0.001..0.1).round(3) } }
  end

  factory :orderbook do
    ask "ask"
    bid "bid"
    array
    initialize_with {
                      {
                        attributes[:ask] => array[0..2],
                        attributes[:bid] => array[3..5]
                      }
                    }
    to_create {}
  end
end
