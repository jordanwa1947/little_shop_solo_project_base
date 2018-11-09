require 'rails_helper'

RSpec.describe 'Merchants Stats' do
  before(:each) do
    @merchant_1, @merchant_2, @merchant_3, @merchant_4 = create_list(:merchant, 4)
    @item_1 = create(:item, user: @merchant_1)
    @item_2 = create(:item, user: @merchant_2)
    @item_3 = create(:item, user: @merchant_3)
    @item_4 = create(:item, user: @merchant_4)

    @user_1 = create(:user, city: 'Tampa', state: 'FL')

    @order_4 = create(:completed_order, user: @user_1)
    create(:fulfilled_order_item, order: @order_4, item: @item_1, created_at: 1.month.ago, updated_at: 28.days.ago)
    @order_5 = create(:completed_order, user: @user_1)
    create(:fulfilled_order_item, order: @order_5, item: @item_1, created_at: 1.month.ago, updated_at: 28.days.ago)
    @order_6 = create(:completed_order, user: @user_1)
    create(:unfulfilled_order_item, order: @order_6, item: @item_1, created_at: 1.month.ago, updated_at: 28.days.ago)
    @order_7 = create(:completed_order, user: @user_1)
    create(:unfulfilled_order_item, order: @order_7, item: @item_1, created_at: 1.month.ago, updated_at: 28.days.ago)

    @order_8 = create(:completed_order, user: @user_1)
    create(:unfulfilled_order_item, order: @order_8, item: @item_2, created_at: 1.days.ago)
    @order_9 = create(:completed_order, user: @user_1)
    create(:fulfilled_order_item, order: @order_9, item: @item_2, created_at: 1.days.ago)
    @order_A = create(:completed_order, user: @user_1)
    create(:fulfilled_order_item, order: @order_A, item: @item_2, created_at: 1.days.ago)
    @order_K = create(:completed_order, user: @user_1)
    create(:fulfilled_order_item, order: @order_K, item: @item_2, created_at: 1.month.ago, updated_at: 27.days.ago)

    @order_B = create(:completed_order, user: @user_1)
    create(:fulfilled_order_item, order: @order_B, item: @item_3, created_at: 1.month.ago, updated_at: 29.days.ago)
    @order_J = create(:completed_order, user: @user_1)
    create(:fulfilled_order_item, order: @order_J, item: @item_3, created_at: 1.month.ago, updated_at: 29.days.ago)
    @order_C = create(:completed_order, user: @user_1)
    create(:unfulfilled_order_item, order: @order_C, item: @item_3, created_at: 3.days.ago)
    @order_E = create(:completed_order, user: @user_1)
    create(:unfulfilled_order_item, order: @order_E, item: @item_3, created_at: 3.days.ago)

    @order_F = create(:completed_order, user: @user_1)
    create(:fulfilled_order_item, order: @order_F, item: @item_4, created_at: 2.days.ago)
    @order_G = create(:completed_order, user: @user_1)
    create(:unfulfilled_order_item, order: @order_G, item: @item_4, created_at: 2.days.ago)
    @order_H = create(:completed_order, user: @user_1)
    create(:unfulfilled_order_item, order: @order_H, item: @item_4, created_at: 1.days.ago)
    @order_I = create(:completed_order, user: @user_1)
    create(:unfulfilled_order_item, order: @order_I, item: @item_4, created_at: 1.days.ago)
  end

  it 'shows top ten merchants by sales this month' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

    visit merchants_path

    merchant = page.all('.top_sales_this_month')

    expect(merchant.first).to have_content("Merchant 4")
    expect(merchant.last).to have_content("Merchant 2")
  end

  it 'shows top ten merchants by sales last month' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

    visit merchants_path

    merchant = page.all('.top_sales_last_month')

    expect(merchant.first).to have_content("Merchant 3")
    expect(merchant.last).to have_content("Merchant 2")
  end

  it 'shows top merchants by fulfillment this month' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

    visit merchants_path

    merchant = page.all('.top_fulfillment_this_month')

    expect(merchant.first).to have_content("Merchant 2")
    expect(merchant.last).to have_content("Merchant 4")
  end

  it 'shows top ten merchants by fulfillment last month' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

    visit merchants_path

    merchant = page.all('.top_fulfillment_last_month')

    expect(merchant.first).to have_content("Merchant 1")
    expect(merchant.last).to have_content("Merchant 2")
  end

  it 'shows top five merchants by fulfillment to users state' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    visit merchants_path
    merchant = page.all('.fulfillment_by_state')

    expect(merchant.first).to have_content("Merchant 2")
    expect(merchant.last).to have_content("Merchant 1")
  end

    it 'shows top five merchants by fulfillment to users city' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit merchants_path

      merchant = page.all('.fulfillment_by_city')

      expect(merchant.first).to have_content("Merchant 2")
      expect(merchant.last).to have_content("Merchant 1")
    end
  end
