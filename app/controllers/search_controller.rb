class SearchController < ApplicationController
  def search
    if params[:q].nil?
      @events = []
    else
      @Events = Event.search params[:q]
    end
  end
end
