class HarryPotterBooks 
	
	def initialize(books)
		@books = books 
	end

	def price 
		price = (@books.inject(0){|price, titles| price + titles})*8
	end

end





RSpec.describe "Harry Potter book discount" do
	
	it "Costs nothing to buy no books" do
		expect(HarryPotterBooks.new([0, 0, 0, 0, 0]).price).to eq(0)
	end

	it "Costs £8 to buy one book" do
		expect(HarryPotterBooks.new([1, 0 ,0 ,0 ,0]).price).to eq(8)
	end

	it "Costs £16 to buy two of the same book" do
		expect(HarryPotterBooks.new([2, 0 ,0 ,0 ,0]).price).to eq(16)
	end

	it "Costs £15.20 to buy two different books" do
		expect(HarryPotterBooks.new([1, 0 ,0 ,1 ,0]).price).to eq(16)
	end

end