#require 'bottles'

class Bottles

  def generate(num)
    begin
      Object.const_get("::#{self.class}::Bottle#{num}").new(num)
    rescue NameError
      BottleNumber.new(num)
    end
 #   { 1 => Bottle1, 0 => Bottle0, 6 => Bottle6 }.fetch(num, BottleNumber).new(num)
  end

  def verse(num)

    bottle = generate(num)
    next_bottle = generate(bottle.decrement)

      "#{bottle.no_more.capitalize} #{bottle.bottles_or_bottle} of beer on the wall, #{bottle.no_more} #{bottle.bottles_or_bottle} of beer.\n" +
        "#{bottle.action}, #{next_bottle.no_more} #{next_bottle.bottles_or_bottle} of beer on the wall.\n"
  end

  def verses(num, num2)
    result = ""
    num.downto(num2).each do |v|
      result += verse(v) + "\n"
    end
    result
  end

  def sing
    verses(99,0)
  end

  class BottleNumber

    attr_reader :num

    def initialize(num)
      @num = num
    end

    def no_more
      "#{num}"
    end
    def action
      "Take #{it_or_one} down and pass it around"
    end
    def bottles_or_bottle
      "bottles"
    end
    def it_or_one
      "one"
    end
    def decrement
      num - 1
    end
    def sixpack
    end
  end

  class Bottle1 < BottleNumber
   def bottles_or_bottle
      "bottle"
    end
    def it_or_one
      "it"
    end
  end

  class Bottle0 < BottleNumber
    def no_more
     "no more"
    end
    def action
      "Go to the store and buy some more"
    end
    def decrement
      99
    end
  end

  class Bottle6 < BottleNumber
    def no_more
      (num / 6).to_s
    end

    def bottles_or_bottle
      "six-pack"
    end
  end
end



describe "singing 99 bottles of beer" do

  let(:song) { Bottles.new }

  it "can sing a typical verse" do
    expected = "8 bottles of beer on the wall, 8 bottles of beer.\nTake one down and pass it around, 7 bottles of beer on the wall.\n"
    expect( song.verse(8) ).to eq( expected )
  end

  it "can sing another typical verse" do
    expected = "3 bottles of beer on the wall, 3 bottles of beer.\nTake one down and pass it around, 2 bottles of beer on the wall.\n"
    expect( song.verse(3) ).to eq( expected )
  end

  it "can sing about 1 bottle" do
    expected = "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"
    expect( song.verse(1) ).to eq( expected )
  end

  it "can sing about 2 bottles" do
    expected = "2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n"
    expect( song.verse(2) ).to eq( expected )
  end

  it "can sing about no more bottles" do
    expected = "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
    expect( song.verse(0) ).to eq( expected )
  end

  it "can string a few verses together" do
    expected = "8 bottles of beer on the wall, 8 bottles of beer.\nTake one down and pass it around, 7 bottles of beer on the wall.\n\n7 bottles of beer on the wall, 7 bottles of beer.\nTake one down and pass it around, 1 six-pack of beer on the wall.\n\n1 six-pack of beer on the wall, 1 six-pack of beer.\nTake one down and pass it around, 5 bottles of beer on the wall.\n\n"
    expect( song.verses(8, 6) ).to eq( expected )
  end

  it "can use 1 six-pack instead of 6 bottles of beer" do
    expected = "7 bottles of beer on the wall, 7 bottles of beer.\nTake one down and pass it around, 1 six-pack of beer on the wall.\n\n1 six-pack of beer on the wall, 1 six-pack of beer.\nTake one down and pass it around, 5 bottles of beer on the wall.\n\n"
    expect( song.verses(7,6) ).to eq( expected )
  end

  it "can use 2 six-packs instead of 12 bottles of beer" do
    expected = "2 six-packs of beer on the wall, 2 six-packs of beer.\nTake one down and pass it around, 11 bottles of beer on the wall.\n\n"
    expect( song.verse(12) ).to eq( expected )
  end

  it "can use 1 crate instead of 24 bottles of beer" do
    expected = "1 crate of beer on the wall, 1 crate of beer.\nTake one down and pass it around, 23 bottles of beer on the wall.\n\n"
    expect( song.verse(24) ).to eq( expected )
  end
end
