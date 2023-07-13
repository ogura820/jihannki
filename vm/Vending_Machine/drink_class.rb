# require './vm_human.rb'
require './money_class.rb'
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