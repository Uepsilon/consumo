#Booking.select('created_at::date','COUNT(id) as counter').group('created_at::date')
#Booking.select('created_at::date','COUNT(id) as counter').between_times(Time.zone.now - 31.days, Time.zone.now).group('created_at::date').to_yaml
class Statistics::OrdersController < ApplicationController
  def index

  end

  def search
    
  end

  def bookings_by_date_and_product()

    # SELECT
    #   "order_items".created_at :: DATE AS datecol,
    #   COUNT(order_items.id) AS counter
    # FROM
    #   "order_items"
    # INNER JOIN deliveries ON order_items.delivery_id = deliveries.id
    # WHERE product_id = 1
    # GROUP BY
    #   "order_items".created_at :: DATE

    date_from = Time.zone.now - 31.days
    date_to   = Time.zone.now

    if params['product_id'].present?
      bookings = OrderItem.select('order_items.created_at::date as date','COUNT(order_items.id) as counter').joins(:delivery).where("deliveries.product_id = '#{params['product_id']}'").between_times(date_from, date_to).group('order_items.created_at::date')
    else
      bookings = OrderItem.select('order_items.created_at::date as date','COUNT(order_items.id) as counter').joins(:delivery).between_times(date_from, date_to).group('order_items.created_at::date')
    end

    graph_data = []
    bookings.each do |booking|
      graph_data.push({date_key: booking.date, value: booking.counter})
    end
    graph_data
  end
  helper_method :bookings_by_date_and_product
end