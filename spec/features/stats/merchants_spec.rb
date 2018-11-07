require 'rails_helper'

RSpec.describe 'Merchants Stats' do
  context 'as a registered user viewing the merchants index' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)

      @user_1 = create(:user, city: 'Denver', state: 'CO')
      @user_2 = create(:user, city: 'Los Angeles', state: 'CA')
      @user_3 = create(:user, city: 'Tampa', state: 'FL')
      @user_4 = create(:user, city: 'NYC', state: 'NY')

      @item_1 = create(:item, user: @merchant_1)

      # Denver/Colorado is 2nd place
      @order_1 = create(:completed_order, user: @user_1)
      create(:fulfilled_order_item, order: @order_1, item: @item_1)
      @order_2 = create(:completed_order, user: @user_1)
      create(:fulfilled_order_item, order: @order_2, item: @item_1)
      @order_3 = create(:completed_order, user: @user_1)
      create(:fulfilled_order_item, order: @order_3, item: @item_1)
      # Los Angeles, California is 1st place
      @order_4 = create(:completed_order, user: @user_2)
      create(:fulfilled_order_item, order: @order_4, item: @item_1)
      @order_5 = create(:completed_order, user: @user_2)
      create(:fulfilled_order_item, order: @order_5, item: @item_1)
      @order_6 = create(:completed_order, user: @user_2)
      create(:fulfilled_order_item, order: @order_6, item: @item_1)
      @order_7 = create(:completed_order, user: @user_2)
      create(:fulfilled_order_item, order: @order_7, item: @item_1)
      # Sorry Tampa, Florida
      @order_8 = create(:completed_order, user: @user_3)
      create(:fulfilled_order_item, order: @order_8, item: @item_1)
      # NYC, NY is 3rd place
      @order_9 = create(:completed_order, user: @user_4)
      create(:fulfilled_order_item, order: @order_9, item: @item_1)
      @order_A = create(:completed_order, user: @user_4)
      create(:fulfilled_order_item, order: @order_A, item: @item_1)
    end

    xit 'shows top ten merchants by sales this month' do

      visit merchants_path

      expect(page).to have_content("")
    end
    xit 'shows top ten merchants by sales last month' do

      visit merchants_path

      expect(page).to have_content("")
    end

    xit 'shows top ten merchants by fulfillment this month' do

      visit merchants_path

      expect(page).to have_content("")
    end

    xit 'shows top ten merchants by fulfillment last month' do

      visit merchants_path

      expect(page).to have_content("")
    end

    xit 'shows top five merchants by fulfillment to users state' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit merchants_path

      expect(page).to have_content("")
    end

    xit 'shows top five merchants by fulfillment to users city' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit merchants_path

      expect(page).to have_content("")
    end
  end
end
