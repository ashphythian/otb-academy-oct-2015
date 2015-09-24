class HarryPotterBooks 
	
	def initialize(books)
		@books = books 
	end

	def price 
 
   		price = 0 

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

  		price

	end

end





RSpec.describe "Harry Potter book discount" do
	
	it "Costs nothing to buy no books" do
		expect(HarryPotterBooks.new([]).price).to eq(0)
	end

	it "Costs £8 to buy one book" do
		expect(HarryPotterBooks.new([1]).price).to eq(8)
	end

	it "Costs £16 to buy two of the same book" do
		expect(HarryPotterBooks.new([2]).price).to eq(16)
	end

	it "Costs £15.20 to buy two different books" do
    	expect(HarryPotterBooks.new([1, 1]).price).to eq(15.20)
	end

	it "Costs £44.80 to buy a selection of books books" do
    	expect(HarryPotterBooks.new([3, 2, 1]).price).to eq(44.80)
	end


end
