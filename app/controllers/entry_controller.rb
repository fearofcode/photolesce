class EntryController < ApplicationController
  PERPAGE = 25

  def index
    params[:page] ||= 1
    params[:page] = [params[:page].to_i, 1].max
   
    @page = params[:page] 
    offset = (@page-1)*PERPAGE
    @entries = Entry.offset(offset).limit(PERPAGE).where("favorite_cnt >= ?", Entry::FAV_THRESHOLD)

    @next_page = (Entry.count > @page*PERPAGE)
  end

  def about
    @feeds = Feed.where("title IS NOT NULL")
  end
end
