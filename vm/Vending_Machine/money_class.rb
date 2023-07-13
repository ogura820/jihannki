require './drink_class.rb'

class Money
  MONEY = [10, 50, 100, 500, 1000].freeze
  attr_accessor  :slot_money
  attr_accessor  :sales
  def initialize
    @slot_money = 0
    @sales = 0
  end

  def current_slot_money
    puts "現在の投入金額は#{@slot_money}です。"
  end

  def current_sales
    puts "現在の売上金額は#{@sales}です。"
  end

  def slot
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