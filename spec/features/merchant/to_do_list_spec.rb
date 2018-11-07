require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe "user visits their dashboard" do
  before(:each) do
    @merchant = create(:merchant)
    @item_1 = create(:item, user: @merchant)
    @item_2 = create(:item, user: @merchant, image: 'https://picsum.photos/200/300/?image=0&blur=true')
  end
  it 'displays item names with placeholder image' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

    visit merchant_path(@merchant)

    expect(page).to_not have_link("#{@item_1.name} edit")
    expect(page).to have_link("#{@item_2.name} edit")
  end
end
