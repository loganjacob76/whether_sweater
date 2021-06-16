require 'rails_helper'

RSpec.describe Image do
  before :each do
    @location = Location.new({:lat=>39.738453, :lng=>-104.984853})
  end

  describe 'create image poro' do
    it 'has all attributes' do
      expect(@location.lattitude).to eq(39.738453)
      expect(@location.longitude).to eq(-104.984853)
    end
  end
end