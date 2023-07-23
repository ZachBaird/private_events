class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update attend_event]

  def index
    now = DateTime.now

    @past_events = Event.past_events(now)
    @current_events = Event.current_events(now)
  end

  def show
    @event = Event.find_by(id: params[:id])
    redirect_to events_path if @event.nil?

    attendee_event_users = AttendingEvent.where(event_id: @event.id).pluck(:user_id)
    @attending = attendee_event_users.include? current_user.id
    @attendees = User.find(attendee_event_users)
  end

  def new; end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id

    if @event.save
      redirect_to root_path
    else
      flash[:alert] = 'Something went wrong creating the event!'
      redirect_to new_event_path
    end
  end

  def attend_event
    @event = Event.find_by(id: params[:id])

    redirect_to events_path if @event.nil?

    attended_event = AttendingEvent.new(attended_event: @event, attending_user: current_user)
    redirect_to "/users/#{current_user.id}" if attended_event.save
  end

  def unattend_event
    @event = Event.find_by(id: params[:id])

    unless @event.nil?
      attended_event = AttendingEvent.find_by(user_id: current_user.id, event_id: @event.id)
      attended_event.destroy
    end

    redirect_to event_path
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    @event.destroy
    redirect_to root_path
  end

  private

  def event_params
    params.permit(:title, :description, :date)
  end
end
