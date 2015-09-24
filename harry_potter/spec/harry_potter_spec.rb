class HarryPotterBooks 
	
	def initialize(books)
		@books = books
		@books2 = @books.dup
	end

	def best_deal 
 
   		price = price2 = 0

   		# discounts including for 5 books
		until @books.empty? do

			@books.delete(0)
			discount = @books.length
		  	if discount == 5
		    	price += 30
		  	elsif discount == 4
		    	price += 25.60
		  	elsif discount == 3
		    	price += 21.60
		  	elsif discount == 2
		    	price += 15.20
		  	elsif discount == 1
		    	price += 8
		  	end
		  	@books.map!{|x| x-1}
  		end

  		# discounts disregarding the 5 book deal
  		until @books2.empty? do

			@books2.delete(0)
			discount2 = @books2.length
		  	if discount2 == 5
		    	price2 += 25.60
		    	@books2[@books2.index(@books2.min)]+=1
		  	elsif discount2 == 4
		    	price2 += 25.60
		  	elsif discount2 == 3
		    	price2 += 21.60
		  	elsif discount2 == 2
		    	price2 += 15.20
		  	elsif discount2 == 1
		    	price2 += 8
		  	end
		  	@books2.map!{|x| x-1}
  		end


  		best_deal = [price,price2].min

  		best_deal

	end

end





RSpec.describe "Harry Potter book discount" do
	
	it "Costs nothing to buy no books" do
		expect(HarryPotterBooks.new([]).best_deal).to eq(0)
	end

	it "Costs £8 to buy one book" do
		expect(HarryPotterBooks.new([1]).best_deal).to eq(8)
	end

	it "Costs £16 to buy two of the same book" do
		expect(HarryPotterBooks.new([2]).best_deal).to eq(16)
	end

	it "Costs £15.20 to buy two different books" do
    	expect(HarryPotterBooks.new([1, 1]).best_deal).to eq(15.20)
	end

	it "Costs £44.80 to buy a selection of books books" do
    	expect(HarryPotterBooks.new([3, 2, 1]).best_deal).to eq(44.80)
	end

	it "Costs £51.20 to buy the example quantity of books" do
    	expect(HarryPotterBooks.new([2,2,2,1,1]).best_deal).to eq(51.20)
	end

	it "Costs £30 to buy one of each" do
    	expect(HarryPotterBooks.new([1,1,1,1,1]).best_deal).to eq(30)
	end

	it "Costs £90 to buy three of each" do
    	expect(HarryPotterBooks.new([3,3,3,3,3]).best_deal).to eq(90)
	end

	it "Costs £113.60 for a random array of books" do
    	expect(HarryPotterBooks.new([5,5,4,2,1]).best_deal).to be_within(0.05).of(113.6)
	end

	it "Costs £55.60 for a random array of books" do
    	expect(HarryPotterBooks.new([2,2,2,2,1]).best_deal).to be_within(0.05).of(55.6)
	end

end
