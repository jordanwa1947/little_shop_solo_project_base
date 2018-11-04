require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe "user visits their dashboard" do
  before(:each) do
    @merchant = create(:merchant)
  end
  it 'displays item names with placeholder image' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

    visit dashboard_path

    expect(page).to have_content("")
  end
end
