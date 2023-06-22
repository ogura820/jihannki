class User

  def initialize
    @vm = VendingMachine.new
  end

  def slot_money(money)
    @vm.sloted_money(money)
  end

  def receive_money
    @vm.return_money
  end

  def check_buyable_drinks
    @vm.inform_buyable_drinks
  end

  def check_drink_types
    @vm.inform_drink_types
  end

  def choose(drink)
    @vm.sell(drink)
  end

end


module Stock
  def initialize
    @cola = {name: "コーラ", price: 120, stock: 5 }
    @water = {name: "水", price: 100, stock: 5 }
    @red_bull = {name: "レッドブル",price: 200, stock: 5 }
    @drinks = [@cola, @water, @red_bull]
  end

  def check_availability_of_(drink)
    drink[:stock] == 0
  end

  def reduce_from_(drink)
    drink[:stock] -= 1
  end
end

class VendingMachine
  include Stock

  MONEY = [10, 50, 100, 500, 1000].freeze

  def initialize
    @slot_money = 0
    @sales = 0
    @cola = {name: "コーラ", price: 120, stock: 5 }
    @water = {name: "水", price: 100, stock: 5 }
    @red_bull = {name: "レッドブル",price: 200, stock: 5 }
    @drinks = [@cola, @water, @red_bull]
  end

  def inform_drink_types
    @drinks
  end

  def current_slot_money
    "投入合計金額は#{@slot_money}円です"
  end

  #自販機は入れられる側なので名称を受動態っぽく変更
  def sloted_money(money)
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
        "#{drink[:name]}" unless there_is_not_enough_money_to_buy(drink) or check_availability_of_(drink)
    end
    buyable_drinks.compact
  end

  private
  
  def there_is_not_enough_money_to_buy(drink)
    drink[:price] >= @slot_money
  end

  def increase_sales_and_reduce_slots_money_amount_of(drink)
    @sales += drink[:price]
    @slot_money -= drink[:price]
  end

  def sell_(drink)
    if check_availability_of_(drink)
      "売り切れ"
    #投入金額が足りない場合 
    elsif  there_is_not_enough_money_to_buy(drink)
      "お金を入れて"
    else
      reduce_from_(drink)
      increase_sales_and_reduce_slots_money_amount_of(drink)
      return_money
      return drink[:name]  # 追記
    end
  end

end
