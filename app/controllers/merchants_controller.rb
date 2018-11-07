class MerchantsController < ApplicationController
  def index
    if current_admin?
      @merchants = User.where(role: :merchant).order(:name)
      @top_merchants_this_month = @merchants.top_merchants_this_month
      @top_merchants_last_month = @merchants.top_merchants_last_month
      @top_fulfilling_this_month = @merchants.top_merchants_fulfilled_this_month
      @top_fulfilling_last_month = @merchants.top_merchants_fulfilled_last_month
      @fastest_fulfilling_for_state = @merchants.fastest_fulfilled_user_state(current_user.state)
      @fastest_fulfilling_for_city = @merchants.fastest_fulfilled_user_city(current_user.city)
    else
      @merchants = User.where(role: :merchant, active: true).order(:name)
      @top_merchants_this_month = @merchants.top_merchants_this_month
      @top_merchants_last_month = @merchants.top_merchants_last_month
      @top_fulfilling_this_month = @merchants.top_merchants_fulfilled_this_month
      @top_fulfilling_last_month = @merchants.top_merchants_fulfilled_last_month
      if current_user
        @fastest_fulfilling_for_state = @merchants.fastest_fulfilled_user_state(current_user.state)
        @fastest_fulfilling_for_city = @merchants.fastest_fulfilled_user_city(current_user.city)
      end
    end
  end

  def show
    render file: 'errors/not_found', status: 404 unless current_user

    @merchant = User.find(params[:id])
    if current_admin?
      @orders = current_user.merchant_orders
      if @merchant.user?
        redirect_to user_path(@merchant)
      end
    elsif current_user != @merchant
      render file: 'errors/not_found', status: 404
    end
  end
end
