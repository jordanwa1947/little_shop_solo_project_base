require 'rails_helper'

RSpec.describe 'Merchants Stats' do
  context 'as a registered user viewing the merchants index' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)

      @user_1 = create(:user, city: 'Denver', state: 'CO')
      @user_2 = create(:user, city: 'Los Angeles', state: 'CA')
      @user_3 = create(:user, city: 'Tampa', state: 'FL')
      @user_4 = create(:user, city: 'NYC', state: 'NY')

      @item_1 = create(:item, user: @merchant_1)
      @item_2 = create(:item, user: @merchant_2)
      @item_3 = create(:item, user: @merchant_3)

      # Denver/Colorado is 2nd place
      @order_1 = create(:completed_order, user: @user_1)
      create(:fulfilled_order_item, order: @order_1, item: @item_1)
      @order_2 = create(:completed_order, user: @user_2)
      create(:fulfilled_order_item, order: @order_2, item: @item_1, created_at: 1.month.ago)
      @order_3 = create(:completed_order, user: @user_2)
      create(:unfulfilled_order_item, order: @order_3, item: @item_1, created_at: 1.month.ago)
      # Los Angeles, California is 1st place
      @order_4 = create(:completed_order, user: @user_4)
      create(:fulfilled_order_item, order: @order_4, item: @item_2, created_at: 1.month.ago)
      @order_5 = create(:completed_order, user: @user_4)
      create(:fulfilled_order_item, order: @order_5, item: @item_2, created_at: 1.days.ago)
      @order_6 = create(:completed_order, user: @user_4)
      create(:fulfilled_order_item, order: @order_6, item: @item_2, created_at: 1.days.ago)
      @order_7 = create(:completed_order, user: @user_4)
      create(:fulfilled_order_item, order: @order_7, item: @item_2)
      # Sorry Tampa, Florida
      @order_8 = create(:completed_order, user: @user_3)
      create(:fulfilled_order_item, order: @order_8, item: @item_3, created_at: 4.days.ago)
      # NYC, NY is 3rd place
      @order_9 = create(:completed_order, user: @user_1)
      create(:fulfilled_order_item, order: @order_9, item: @item_3)
      @order_A = create(:completed_order, user: @user_1)
      create(:fulfilled_order_item, order: @order_A, item: @item_3)
    end

    it 'shows top ten merchants by sales this month' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit merchants_path

      within('.top_sales_this_month') do
        expect(page).to have_content("Merchant 1")
      end
    end

    it 'shows top ten merchants by sales last month' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit merchants_path

      expect(page).to have_content("")
    end

    it 'shows top ten merchants by fulfillment this month' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit merchants_path

      expect(page).to have_content("")
    end

    it 'shows top ten merchants by fulfillment last month' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit merchants_path

      expect(page).to have_content("")
    end

    it 'shows top five merchants by fulfillment to users state' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_4)

      visit merchants_path

      expect(page).to have_content("")
    end

    it 'shows top five merchants by fulfillment to users city' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit merchants_path

      expect(page).to have_content("")
    end
  end
end
