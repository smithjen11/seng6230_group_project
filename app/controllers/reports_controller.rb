class ReportsController < ApplicationController
  def new
  end
  
  def create
    start_date = Date.new report_params["start_date(1i)"].to_i, report_params["start_date(2i)"].to_i, report_params["start_date(3i)"].to_i
    end_date = Date.new report_params["end_date(1i)"].to_i, report_params["end_date(2i)"].to_i, report_params["end_date(3i)"].to_i + 1

    @orders = Order.where('created_at between ? and ?', start_date.to_datetime, end_date.to_datetime)
    respond_to do |format|
        format.html { render 'show', locals: {orders: @orders, start_date: start_date, end_date: end_date} }
    end
  end

  def show
  end
  
  
  private
  
  def report_params
    params.require(:report).permit('start_date(1i)', 'start_date(2i)', 'start_date(3i)', 'end_date(1i)', 'end_date(2i)', 'end_date(3i)')
  end
end
