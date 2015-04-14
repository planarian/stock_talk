class CompaniesController < ApplicationController

  def show
    @current = Company.find(params[:id]).name
    respond_to do |format|
      format.json do
        render json: get_record
      end
      format.any do
        render :show
      end
    end
  end

  def get_record
    record = []
    days = Day.includes(:daily_totals, :share_prices)
    days.each do |this_day|
      record << { day: this_day.date.strftime('%b %-d'),
                  tweets: this_day.daily_totals.find_by(company: params[:id]).count,
                  share_price: this_day.share_prices.find_by(company: params[:id]).price
                 }
    end
    record
  end

end