class RunStampsController < ApplicationController
  def index
    @run_stamps = RunStamp.all
  end

  def new
    @run_stamp = RunStamp.new
  end

  def create
    @run_stamp = RunStamp.new(params[:run_stamp])
    @run_stamp.timeStop = Time.new
    if @run_stamp.save
      flash[:notice] = "Thank you for logging your time"
      redirect_to root_path
    else
      flash.now[:error] = 'Scotty, something be wrong'
      render action: "new"
    end
  end

end
