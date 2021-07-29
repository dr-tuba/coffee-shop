class Customer < ActiveRecord::Base
    has_many :orders, dependent: :destroy
    has_many :coffees, through: :orders

    def self.names
        pluck(:name)
    end

    def order_coffee(coffee_title, price)
        coffee = Coffee.find_or_create_by(title: coffee_title)
        order = Order.create(customer_id: id, coffee_id: coffee.id, price: price)
        
        order.receipt
    end

    def total_purchases_amount
        orders.sum(:price)
    end

    def dislike_coffee(coffee_title)
        coffee = Coffee.find_by(title: coffee_title)
        last_coffee_order = orders.where("coffee_id = ?", coffee.id).last
        
        last_coffee_order.destroy
        puts "#{name} has been refunded $#{order.price}"
    end
end