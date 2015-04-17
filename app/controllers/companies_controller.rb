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
    record = {tweets: DailyTotal.csv_header, prices: SharePrice.csv_header}
    days = Day.includes(:daily_totals, :share_prices).where("date < '#{Date.today}'")
    days.each do |this_day|
      record[:tweets] += this_day.daily_totals.find_by(company: params[:id]).try(:csv_row).to_s
      record[:prices] += this_day.share_prices.find_by(company: params[:id]).try(:csv_row).to_s
    end
    record
  end

end