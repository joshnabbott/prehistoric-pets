class CaresheetsController < ApplicationController
  def show
    @caresheet = Caresheet.find(params[:id])
    raise Error404 unless @caresheet.is_active
  end
end
