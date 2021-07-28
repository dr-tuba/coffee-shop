class Coffee < ActiveRecord::Base
    has_many :orders, dependent: :destroy
    has_many :customers, through: :orders

    def unique_customer_name
        customers.pluck(:name)
    end

    def self.most_ordered
        self.find(Order.distinct.count("coffee_id"))
    end
end