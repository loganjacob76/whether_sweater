require 'rails_helper'

RSpec.describe BookFacade do
  describe 'class methods' do
    before :each do
      @facade = BookFacade.find_books('denver, co', 4)
    end

    it '.find_books', :vcr do
      expect(@facade).to be_a Book
      expect(@facade.books.count).to eq(4)
    end
  end
end