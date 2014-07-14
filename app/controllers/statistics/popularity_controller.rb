class Statistics::PopularityController < ApplicationController
  def index  

  end

  def products_by_popularity
    Product.select('products.name, COUNT(products.id) as counter').joins('INNER JOIN "deliveries" ON "products"."id" = "deliveries"."product_id"').joins('INNER JOIN "order_items" ON "order_items"."delivery_id" = "deliveries"."id"').group('products.id').order('counter DESC')
  end
  helper_method :products_by_popularity

  def categories_by_popularity
    Category.select('categories.title', 'COUNT(categories.id) AS counter').joins('INNER JOIN "products" ON "categories"."id" = "products"."category_id"').joins('INNER JOIN "deliveries" ON "deliveries"."product_id" = "products"."id"').joins('INNER JOIN "order_items" ON "order_items"."delivery_id" = "deliveries"."id"').group('categories.id').order('counter DESC')
  end
  helper_method :categories_by_popularity

  def users_by_bookings
    User.select(:first_name,:last_name,'COUNT(users.id) as counter').joins('INNER JOIN "bookings" ON "bookings"."user_id" = "users"."id"').where("bookings.bookable_type = 'Order'").group('users.id').order('counter DESC')
  end
  helper_method :users_by_bookings

  def users_by_deliveries
    User.select(:first_name,:last_name,'COUNT(users.id) as counter').joins('INNER JOIN "bookings" ON "bookings"."user_id" = "users"."id"').where("bookings.bookable_type = 'Delivery'").group('users.id').order('counter DESC')
  end
  helper_method :users_by_deliveries
end
