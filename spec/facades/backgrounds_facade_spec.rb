require 'rails_helper'

RSpec.describe BackgroundsFacade do
  before :each do
    @facade = BackgroundsFacade.find_image('denver, co')
  end

  describe 'class methods', :vcr do
    it 'returns an image poro' do
      expect(@facade).to be_a Image
    end
  end
end