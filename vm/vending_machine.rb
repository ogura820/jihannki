class VendingMachine
  # ステップ０　お金の投入と払い戻し
  # ステップ１　扱えないお金

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze

  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
    # 自販機に入っているドリンクは３種類
    @cola = {name: "コーラ", price: 120, stock: 5 }
    @water = {name: "水", price: 100, stock: 5 }
    @red_bull = {name: "レッドブル",price: 200, stock: 5 }
    # 自販機に入っているドリンク3種類の情報を配列に格納
    @drinks = [@cola, @water, @red_bull]
    # 最初売上金額は0円
    @sales = 0
  end

  def inform_drink_types
    @drinks
  end

  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    "投入合計金額は#{@slot_money}円です"
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return "対応していないものです" unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
    "#{money}円追加され、投入金額合計は#{@slot_money}円になりました"
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts "#{@slot_money}円のお釣りです"
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
    "投入金額は#{@slot_money}円になりました"
  end

# ステップ3　購入
  def sell(drinks)
    case drinks
    when :cola  
      #在庫が0の場合
      if @cola[:stock] == 0 
        puts "売り切れ"
      #投入金額が足りない場合 
      elsif  @cola[:price] > @slot_money
        puts "お金を入れて"
      #投入金額も在庫の条件も十分な場合 
      else 
        #ジュースの在庫を減らし、売り上げ金額を増やし、投入金額合計を減らす
        @cola[:stock] -= 1
        @sales += @cola[:price]
        @slot_money -= @cola[:price]
        puts "#{@slot_money}円のお釣りです"
        # 自動販売機に入っているお金を0円に戻す
        @slot_money = 0
        return @cola[:name]  # 追記
      end
    when :water  
      if @water[:stock] == 0 
        puts "売り切れ"
      elsif  @water[:price] > @slot_money
        puts "お金を入れて"
      else 
        @water[:stock] -= 1
        @sales += @water[:price]
        @slot_money -= @water[:price]
        puts "#{@slot_money}円のお釣りです"
        # 自動販売機に入っているお金を0円に戻す
        @slot_money = 0
        return @water[:name]  # 追記
      end
    when :red_bull  
      if @red_bull[:stock] == 0 
        puts "売り切れ"
      elsif  @red_bull[:price] > @slot_money
        puts "お金を入れて"
      else 
        @red_bull[:stock] -= 1
        @sales += @red_bull[:price]
        @slot_money -= @red_bull[:price]
        puts "#{@slot_money}円のお釣りです"
        # 自動販売機に入っているお金を0円に戻す
        @slot_money = 0
        return @red_bull[:name]  # 追記
      end
    else
      puts "cola、water、red_bull のみ選択可能です。"
    end
  end

  # 売上計算
  def calculate_sales
    "売上金額は#{@sales}円です。" 
  end

# ステップ４　投入金額、在庫の点で購入可能なドリンクのリストを取得
  def inform_buyable_drinks
    buyable_drinks = @drinks.map do |drink|
      if (drink[:price] <= @slot_money) && (drink[:stock] > 0)
        "#{drink[:name]}"
      end
    end
    buyable_drinks.compact
  end


# 要件外　新しいジュースの種類の補充
  def replenished(drink_name,drink_price,drink_stock)
    drink_name = {}
    drink_name [price] = drink_price
    drink_name [stock] = drink_stock
    drinks = {}
    drinks [drink_nmae] = drink_
    #drink_types = {name: drink_name, price: drink_price, stock: drink_stock}
    @drinks = { drink_name: {price: drink_price, stock: drink_stock}}
    #drinks << drink_types
    @cola = {price: 150, stock: 5 }
    @water = {price: 150, stock: 5 }
    @tea = {price: 150, stock: 5 }  
  end
end

#http://devtesting.jp/tddbc/?TDDBC%E5%A4%A7%E9%98%AA3.0%2F%E8%AA%B2%E9%A1%8C
