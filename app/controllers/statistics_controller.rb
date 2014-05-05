class StatisticsController < ApplicationController

  def index  
    @orders   = Order.all

    @date_formats = [:month, :week, :day]
    @orders_by_date_format = {}
    @date_formats.each do |date_format|
      @orders_by_date_format[date_format] = orders_by_product(date_format)
    end

    @bookings = Booking.all
  end

  def orders_by_product(date_format)
    # logger = ActiveRecord::Base.logger = Logger.new(STDOUT)
    # @product_orders = Order.all.group('product_id').count
    @product_orders = Order.count(:group => "year(created_at),month(created_at)")

    orders = Order.all.order('created_at, id')

    case date_format
      when :month
        orders = orders.group_by { |order| order.created_at.beginning_of_month.strftime('%B') }
      when :week
        orders = orders.group_by { |order| order.created_at.beginning_of_week.strftime('%W') }
      when :day
        orders = orders.group_by { |order| order.created_at.beginning_of_day.strftime('%A') }
    end
    

    order_count_by_date_key = []

    orders.each do |date_key, values|
      order_count_by_date_key.push({date_key: date_key, value: values.count})
    end 

    order_count_by_date_key
  end
end
