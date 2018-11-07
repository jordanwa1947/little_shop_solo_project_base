require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe "user visits their dashboard" do
  it 'displays links to edit items with placeholder images' do
    merchant = create(:merchant)
    item_1 = create(:item, user: merchant)
    item_2 = create(:item, user: merchant, image: 'https://picsum.photos/200/300/?image=0&blur=true')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

    visit merchant_path(merchant)

    expect(page).to_not have_link("#{item_1.name} edit")
    expect(page).to have_link("#{item_2.name} edit")

    click_link("#{item_2.name} edit")

    expect(current_path).to eq(edit_merchant_item_path(merchant, item_2))
  end

  it 'displays number of unfilled orders with revenue impact' do
    merchant = create(:merchant)

    user_1 = create(:user)
    item_1 = create(:item, user: merchant)

    order_1 = create(:completed_order, user: user_1)
    create(:unfulfilled_order_item, order: order_1, item: item_1)
    order_2 = create(:completed_order, user: user_1)
    create(:unfulfilled_order_item, order: order_2, item: item_1)
    order_3 = create(:completed_order, user: user_1)
    create(:unfulfilled_order_item, order: order_3, item: item_1)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

    visit merchant_path(merchant)

    expect(page).to have_content("You have #{OrderItem.sum(:quantity)} unfulfilled orders worth #{number_to_currency(OrderItem.sum("quantity*price"))}")
  end
end
