class Customer < ActiveRecord::Base
    has_many :orders, dependent: :destroy
    has_many :coffees, through: :orders

    def self.names
        self.pluck(:name)
    end

    def order_coffee(coffee_title, price)
        Order.create(customer_id: self.id, coffee_id: Coffee.find_or_create_by(title: coffee_title).id, price: price)
        #orders.all.last.receipt this should work but self.orders.all doesn't show the recently added coffee order. 
        Order.all.where("customer_id = ?", id).last.receipt
    end

    def total_purchases_amount
        #orders.pluck(:price).sum this should work, but it's not getting the newest coffee after doing order_coffee
        Order.all.where("customer_id = ?", id).pluck(:price).sum
    end

    def dislike_coffee(coffee_title)
        puts "#{name} has been refunded $#{orders.find_by(coffee_id: Coffee.find_by(title: coffee_title).id).price}"
        orders.find_by(coffee_id: Coffee.find_by(title: coffee_title).id).destroy
    end
end