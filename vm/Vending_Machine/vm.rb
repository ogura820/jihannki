require './drink_class.rb'
require './money_class.rb'

class VendingMachine
  def initialize
    @drink = Drink.new
    @money = Money.new
  end

  def start_operation
    while true
      puts "---------------------\nどうする？\n---------------------\n1.投入金額を確認する\n2.お金を入れる\n3.購入可能な商品を見る\n4.商品を購入する\n5.やめる\n---------------------"
      choice = gets.chomp.to_i
      case choice
        when 1
          @money.current_slot_money
        when 2
          @money.slot
        when 3
          @drink.inform_drink_types
        when 4
          sell
        when 5
          @money.return_money
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
    if  @drink.buyable?(choice_drink, @money.slot_money)
        purchase_process(choice_drink)
    else
    end
  end

  def purchase_process(index)
    @money.slot_money -= @drink.drink_list[index][:price]
    @drink.drink_list[index][:stock] -= 1
    @money.sales += @drink.drink_list[index][:price]
    puts "ガチャン"
    puts "#{@drink.drink_list[index][:name]}"
  end

end

vm = VendingMachine.new
vm.start_operation
