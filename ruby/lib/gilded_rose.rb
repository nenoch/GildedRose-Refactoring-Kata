class GildedRose

  def initialize(items)
    @items = items
  end

  def update_inventory
    update_sellbydate
    update_quality
  end

  def update_sellbydate
    @items.each do |item|
      item.sell_in -= 1
    end
  end

  def update_quality
    @items.each do |item|
      case item.name
      when "Aged Brie"
        item.quality += 1
      when "Backstage passes to a TAFKAL80ETC concert"
        if item.sell_in <= 10 && item.sell_in > 5
          item.quality += 2
        elsif item.sell_in <= 5 && item.sell_in >= 0
          item.quality += 3
        elsif item.sell_in < 0
          item.quality = 0
        else
          item.quality += 1
        end
      when "Sulfuras, Hand of Ragnaros"
        item.quality = item.quality
      when "Conjured Mana Cake"
        if item.sell_in > 0
          item.quality -= 2
        else
          item.quality -= 4
        end
      else
        if item.sell_in > 0
          item.quality -= 1
        else
          item.quality -= 2
        end
      end
    end
  end

#
#   def update_quality
#     @items.each do |item|
#       if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
#         if item.quality > 0
#           if item.name != "Sulfuras, Hand of Ragnaros"
#             item.quality = item.quality - 1
#           end
#         end
#       else
#         if item.quality < 50
#           item.quality = item.quality + 1
#           if item.name == "Backstage passes to a TAFKAL80ETC concert"
#             if item.sell_in < 11
#               if item.quality < 50
#                 item.quality = item.quality + 1
#               end
#             end
#             if item.sell_in < 6
#               if item.quality < 50
#                 item.quality = item.quality + 1
#               end
#             end
#           end
#         end
#       end
#       if item.name != "Sulfuras, Hand of Ragnaros"
#         item.sell_in = item.sell_in - 1
#       end
#       if item.sell_in < 0
#         if item.name != "Aged Brie"
#           if item.name != "Backstage passes to a TAFKAL80ETC concert"
#             if item.quality > 0
#               if item.name != "Sulfuras, Hand of Ragnaros"
#                 item.quality = item.quality - 1
#               end
#             end
#           else
#             item.quality = item.quality - item.quality
#           end
#         else
#           if item.quality < 50
#             item.quality = item.quality + 1
#           end
#         end
#       end
#     end
#   end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
