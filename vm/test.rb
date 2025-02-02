class VendingMachine

  MONEY = [10, 50, 100, 500, 1000].freeze

  def initialize
    @slot_money = 0
    @cola = {name: "コーラ", price: 120, stock: 5 }
    @water = {name: "水", price: 100, stock: 5 }
    @red_bull = {name: "レッドブル",price: 200, stock: 5 }
    @drinks = [@cola, @water, @red_bull]
    @sales = 0
  end

  def inform_drink_types
    @drinks
  end

  def current_slot_money
    "投入合計金額は#{@slot_money}円です"
  end

  def slot_money(money)
    return "対応していないものです" unless MONEY.include?(money)
    @slot_money += money
    "#{money}円追加され、投入金額合計は#{@slot_money}円になりました"
  end

  def return_money
    puts "#{@slot_money}円のお釣りです"
    @slot_money = 0
    "投入金額は#{@slot_money}円になりました"
  end

  def sell(drinks)
    case drinks
      when :cola  
        sell_(@cola)
      when :water  
        sell_(@water)
      when :red_bull  
        sell_(@red_bull)
      else
        puts "cola、water、red_bull のみ選択可能です。"
    end
  end

  def calculate_sales
    "売上金額は#{@sales}円です。" 
  end

  def inform_buyable_drinks
    buyable_drinks = @drinks.map do |drink|
        "#{drink[:name]}" unless there_is_not_enough_money_to_buy(drink) or there_is_no_stock_of(drink)
    end
    buyable_drinks.compact
  end

  private

  def there_is_no_stock_of(drink)
    drink[:stock] == 0
  end
  
  def there_is_not_enough_money_to_buy(drink)
    drink[:price] >= @slot_money
  end

  def reduce_stock_of(drink)
    drink[:stock] -= 1
  end

  def increase_sales_and_reduce_slots_money_amount_of(drink)
    @sales += drink[:price]
    @slot_money -= drink[:price]
  end

  def sell_(drink)
    if there_is_no_stock_of(drink)
      "売り切れ"
    #投入金額が足りない場合 
    elsif  there_is_not_enough_money_to_buy(drink)
      "お金を入れて"
    else
      reduce_stock_of(drink)
      increase_sales_and_reduce_slots_money_amount_of(drink)
      return_money
      return drink[:name]  # 追記
    end
  end

end

