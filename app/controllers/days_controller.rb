class DaysController < ApplicationController
  def dump
    @days = Day.all
    @companies = Company.all.order(:id => :asc)
  end
end