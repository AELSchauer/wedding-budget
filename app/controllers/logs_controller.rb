class LogsController < ApplicationController
  def index
    @logs = Log.paginate(:page => params[:page])
  end

  def show
    @log = Log.find(params[:id])
  end
end
