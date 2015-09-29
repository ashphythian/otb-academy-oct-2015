class HarryPotterBooks 
	
	def initialize(books)
		@books = books
		@books2 = @books.dup
		@bookprice = 8
		@discount_5 = 0.75
		@discount_4 = 0.8
		@discount_3 = 0.9
		@discount_2 = 0.95
	end

	def price 
 
   		price = 0

		until @books.empty? do

			@books.delete(0)
			discount = @books.length

		  	if discount == 5
		  		if @books.uniq.length > 1 						# if there are different values, the 4 discount is optimal
			    	price += 4 * @bookprice * @discount_4 		# ignoring the 5
			    	@books[@books.index(@books.min)]+=1 		# preemptively readding a book
			    else price += 5 * @bookprice * @discount_5		# if all values are the same, it is optimal to use the 5 discount
			    end
		  	elsif discount == 4
		    	price += 4 * @bookprice * @discount_4
		  	elsif discount == 3
		    	price += 3 * @bookprice * @discount_3
		  	elsif discount == 2
		    	price += 2 * @bookprice * @discount_2
		  	elsif discount == 1
		    	price += @bookprice
		  	end
		  	@books.map!{ |x| x - 1 }
  		end

  		price
  		
	end
end

# RSpec tests

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

	it "Costs £51.20 to buy the example quantity of books" do
    	expect(HarryPotterBooks.new([2,2,2,1,1]).price).to eq(51.20)
	end

	it "Costs £51.20 for a the previous quantity in a different order" do
    	expect(HarryPotterBooks.new([1,1,2,2,2]).price).to eq(51.20)
	end

	it "Costs £30 to buy one of each" do
    	expect(HarryPotterBooks.new([1,1,1,1,1]).price).to eq(30)
	end

	it "Costs £90 to buy three of each" do
    	expect(HarryPotterBooks.new([3,3,3,3,3]).price).to eq(90)
	end

	it "Costs £113.60 for a random array of books" do
    	expect(HarryPotterBooks.new([5,5,4,2,1]).price).to be_within(0.005).of(113.6)
	end

	it "Costs £55.60 for a random array of books" do
    	expect(HarryPotterBooks.new([2,2,2,2,1]).price).to be_within(0.005).of(55.6)
	end

	it "Costs £141.20 for an example off the internet" do
    	expect(HarryPotterBooks.new([5, 5, 4, 5, 4]).price).to eq(141.2)
	end


end
