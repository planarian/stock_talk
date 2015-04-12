class CompaniesController < ApplicationController

  def show
    @current = Company.find(params[:id]).name
    @record = []
    
    days = Day.includes(:daily_totals, :share_prices)
    days.each do |this_day|
      @record << { day: this_day.date, 
                   tweets: this_day.daily_totals.find_by(company: params[:id]).count,
                   share_price: this_day.share_prices.find_by(company: params[:id]).price
                 }
    end
  end
end