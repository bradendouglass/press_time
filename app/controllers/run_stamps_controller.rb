class RunStampsController < ApplicationController
  def index
    @run_stamps = RunStamp.all

    respond_to do |format|
      format.html
    end
  end

  def new
    @run_stamp = RunStamp.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @run_stamp = RunStamp.new(params[:run_stamp])
    @run_stamp.timeStop = Time.new

    respond_to do |format|
      if @run_stamp.save
        flash[:notice] = "Thank you for logging your time"
        format.html {redirect_to root_path}
      else
        flash.now[:error] = 'Scotty, something be wrong'
        format.html {render action: "new"}
      end
    end
  end

end
