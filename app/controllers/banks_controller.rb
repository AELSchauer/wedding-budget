class BanksController < ApplicationController
  def index
    @banks = Bank.fuzzy_search_by_name(search_params).paginate(:page => params[:page])
  end

  def show
  end

  private

  def search_params
    params[:bank_search].nil? ? "" : params[:bank_search][:name]
  end
end
