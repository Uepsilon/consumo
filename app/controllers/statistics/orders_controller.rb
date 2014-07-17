#Booking.select('created_at::date','COUNT(id) as counter').group('created_at::date')
#Booking.select('created_at::date','COUNT(id) as counter').between_times(Time.zone.now - 31.days, Time.zone.now).group('created_at::date').to_yaml
class Statistics::OrdersController < ApplicationController
  def index
    @date_from = Time.zone.now - 31.days
    @date_to   = Time.zone.now

    if params['date_from'].present?
      @date_from = DateTime.parse("#{params['date_from']} 00:00:00 GMT+1")
    end

    if params['date_to'].present?
      @date_to = DateTime.parse("#{params['date_to']} 23:59:59 GMT+1")
    end
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

    if params['product_id'].present?
      product_condition = "deliveries.product_id = '#{params['product_id']}'"  
    else
      product_condition = ""
    end

    bookings = OrderItem.select('order_items.created_at::date as date','COUNT(order_items.id) as counter').joins(:delivery).where(product_condition).between_times(@date_from, @date_to).group('order_items.created_at::date').order('order_items.created_at::date ASC')

    # timestamp * 1000 = js special
    graph_data = []
    bookings.each do |booking|
      graph_data.push({x: (booking.date.to_time.to_i * 1000), y: booking.counter.to_i})
    end
    graph_data
  end
  helper_method :bookings_by_date_and_product
end