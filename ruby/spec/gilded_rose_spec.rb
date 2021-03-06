require './lib/gilded_rose'


describe GildedRose do

  describe "#update_inventory" do

    it "update the inventory at the end of each day" do
      items = [Item.new("foo", 10, 10)]
      GildedRose.new(items).update_inventory
      expect(items[0].sell_in).to eq 9
      expect(items[0].quality).to eq 9

    end

  end

  describe "#update_sellbydate" do

    it "decreases the sell by date by 1" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_sellbydate
      expect(items[0].sell_in).to eq -1
    end

    it "sulfuras sellbydate stays the same" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 10)]
      GildedRose.new(items).update_sellbydate
      expect(items[0].sell_in).to eq 10
    end

  end

  describe "#update_quality" do

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq "foo"
    end

    it "regular items quality decreases -1 every day" do
      items = [Item.new("foo", 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 9
    end

    it "regular items quality decreases -2 after sell by date" do
      items = [Item.new("foo", 0, 8)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 6
    end

    it "aged brie quality increase +1 every day" do
      items = [Item.new("Aged Brie", 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 11
    end

    it "sulfuras quality stays the same" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 10
    end

    it "backstage passes quality increases +2 10 to 6 days to sell by date" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 8, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 12
    end

    it "backstage passes quality increases +3 5 to 0 days to sell by date" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 13
    end

    it "backstage passes quality drops to 0 after concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end

    it "conjured items quality decreases -4 after sell by date" do
      items = [Item.new("Conjured Mana Cake", 0, 8)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 4
    end

    it "conjured items quality decreases -2 every day" do
      items = [Item.new("Conjured Mana Cake", 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 8
    end

    it "conjured items' quality decreases -4 after sell by date" do
      items = [Item.new("Conjured Mana Cake", 0, 8)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 4
    end

  end

  describe "#check_max_min_quality" do

    it "quality had a min of 0" do
      items = [Item.new("foo", 10, 0)]
      GildedRose.new(items).update_inventory
      expect(items[0].quality).to eq 0
    end

    it "quality had a max of 50" do
      items = [Item.new("Aged Brie", 10, 50)]
      GildedRose.new(items).update_inventory
      expect(items[0].quality).to eq 50
    end

  end

end
