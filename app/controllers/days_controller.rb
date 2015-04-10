class DaysController < ApplicationController
  def dump
    @days = Day.all
    @companies = Company.all
  end
end