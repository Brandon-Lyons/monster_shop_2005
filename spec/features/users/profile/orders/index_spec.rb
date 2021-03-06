require 'rails_helper'

RSpec.describe "order profile page", type: :feature do
  describe "As a logged-in user with orders" do
    before :each do
      @user = User.create!(name:"Luke Hunter James-Erickson", address:"123 Lane", city:"Denver", state:"CO", zip:"88888", email: "chadrick@gmail.com", password:"Iamapassword", password_confirmation:"Iamapassword", role: 0)
      @bike_shop = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @bike_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @item_2 = @bike_shop.items.create!(name: "Bike pump", description: "XYZ", price: 20, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 30)
      @order_1 = @user.orders.create!(name: "Tommy boy", address: "1234 Street", city: "Metropolis", state: "CO", zip: 12345)
      @item_order_1 = ItemOrder.create!(order: @order_1, item: @tire, price: @tire.price, quantity: 10, fulfilled?: true)
      @item_order_2 = ItemOrder.create!(order: @order_1, item: @item_2, price: @item_2.price, quantity: 10, fulfilled?: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "displays all orders I've made with info" do
      visit "/profile/orders"

      within ("#order-#{@order_1.id}") do
        expect(page).to have_link("Order: #{@order_1.id}")
        expect(page).to have_content("Order date: #{@order_1.created_at}")
        expect(page).to have_content("Last update: #{@order_1.updated_at}")
        expect(page).to have_content("Status: #{@order_1.status}")
        expect(page).to have_content("Quantity: #{@order_1.total_quantity}")
        expect(page).to have_content("Total price: #{@order_1.grandtotal}")
      end
    end

    it "can link to an individual order's show page" do
      visit "/profile/orders"

      click_link "Order: #{@order_1.id}"
      expect(current_path).to eq("/profile/orders/#{@order_1.id}")
    end

    it "can change order status from pending to packaged when all items fulfilled" do
      @order_1.package_order

      expect(@order_1.status).to eq("Packaged")
    end

  end
end
