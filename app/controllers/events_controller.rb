class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :register]

  def index
    # @events = Event.all
    @events = Event.filter(params.slice(:topics,:location,:start))
  end

  def show
    @registrations = Registration.where event_id:@event
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to  action: :index, notice: 'Event was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to action: :index, notice: 'Event was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def register
    @registration = Registration.new(user:current_user,event:@event, name:current_user.full_name)
    respond_to do |format|
      if  @registration.save
        format.html {redirect_to action: :index, notice: "Successfully registered for #{@event.name}"}
      else
        format.html {render :show, notice: "Unable to register for event"}
      end
    end
  end


end

private

def set_event
  @event = Event.find(params[:id])
end

def event_params
  params.require(:event).permit(:name, :start_at, :finish_at, :description)
end

def topics
  params[:topics].slice
end
