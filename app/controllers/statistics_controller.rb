class StatisticsController < ApplicationController

  def index  
    @orders   = Order.all

    @date_formats = [:year, :month, :week, :day, :hour]
    @orders_by_date_format = {}
    @date_formats.each do |date_format|
      @orders_by_date_format[date_format] = orders_by_product(date_format)
      @test = @orders_by_date_format[date_format]
    end

    @bookings = Booking.all
  end

  def orders_by_product(date_format)
    @product_orders = Order.count(:group => "year(created_at),month(created_at)")
    orders = Order.all.order('created_at, id')

    case date_format
      when :year
        orders = orders.group_by { |order| l(order.created_at.beginning_of_year) }
      when :month
        orders = orders.group_by { |order| l(order.created_at.beginning_of_month, format: '%B') }
      when :week
        orders = orders.group_by { |order| l(order.created_at.beginning_of_week, format: '%W') }
      when :day
        orders = orders.group_by { |order| l(order.created_at.beginning_of_day, format: '%A') }
      when :hour
        orders = orders.group_by { |order| l(order.created_at.beginning_of_hour) }
    end

    order_count_by_date_key = []

    orders.each do |date_key, values|
      order_count_by_date_key.push({date_key: date_key, value: values.count})
    end 

    order_count_by_date_key
  end
end
