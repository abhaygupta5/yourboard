class NotificationsController < ApplicationController
	  before_action :authenticate_user!
    before_action :set_notifications
    respond_to :js, :json, :html

    def index
    end

    def mark_as_read
	    Notification.find_by_id(params[:id]).update_attribute(:read_at, Time.zone.now)
      redirect_to post_path(Notification.find(params[:id]).notifiable_id)
	  end

	    
  	private

    def set_notifications
      @notifications = Notification.where(recipient: current_user).unread
    end
end
