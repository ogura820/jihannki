class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @slot_money = 0
    @sales = 0
    @drink = Drink.new
  end

  def start_operation
    while true
      puts "---------------------\nどうする？\n---------------------\n1.投入金額を確認する\n2.お金を入れる\n3.購入可能な商品を見る\n4.商品を購入する\n5.やめる\n---------------------"
      choice = gets.chomp.to_i
      case choice
        when 1
          current_slot_money
        when 2
          slot_money
        when 3
          @drink.inform_drink_types
        when 4
          sell
        when 5
          return_money
          return
        else
          puts "1~5の数字を入力してください。"
      end
    end
  end

  private

  def sell
    puts "何を買いますか？"
    puts "0.コーラ 1.水 2.レッドブル"
    choice_drink = gets.to_i
    if  @drink.buyable?(choice_drink, @slot_money)
        purchase_process(choice_drink)
    else
    end
  end

  def current_slot_money
    puts "現在の投入金額は#{@slot_money}です。"
  end

  def current_sales
    puts "現在の売上金額は#{@sales}です。"
  end

  def purchase_process(index)
    @slot_money -= @drink.drink_list[index][:price]
    @drink.drink_list[index][:stock] -= 1
    @sales += @drink.drink_list[index][:price]
    puts "ガチャン"
    puts "#{@drink.drink_list[index][:name]}"
  end

  def slot_money
    puts "お金ちょうだい"
    money = gets.chomp.to_i
    return "種類が違いますよ。" unless MONEY.include?(money)
    @slot_money += money
    puts "投入金額：#{money}円  投入金額合計:#{@slot_money}円"
  end

  def return_money
    puts "お釣り : #{@slot_money}円"
    @slot_money = 0
  end
end

# ジュースの管理
class Drink
  attr_reader :drink_list 
  def initialize
    @drink_list = [
                    { name: "コーラ", price: 120, stock: 5 }, 
                    { name: "水", price: 100, stock: 5 }, 
                    { name: "レッドブル", price: 200, stock: 5 }
                  ]
  end

  def inform_drink_types
    @drink_list.each_with_index do |drink, i|
      puts "#{drink[:name]}は#{drink[:price]}円で在庫は#{drink[:stock]}本です。"
    end
  end

  def buyable?(index, slot_money)
    if present?(index) && enough_money?(index, slot_money) && enough_stock?(index)
      true
    else 
      nil
    end
  end

  private

  def present?(index)
    if @drink_list[index]
      true
    else
      puts "正しい番号を入力してください"
      nil
    end
  end

  def enough_money?(index, slot_money)
    if slot_money >= @drink_list[index][:price]
      true
    else
      puts "お金が足りません"
      nil
    end
  end

  def enough_stock?(index)
    if 0 < @drink_list[index][:stock]
      true
    else
      puts "売り切れです" 
      nil
    end
  end

end

vm = VendingMachine.new
vm.start_operation

