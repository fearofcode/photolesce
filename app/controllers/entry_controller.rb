class EntryController < ApplicationController
  PERPAGE = 25
  FAV_THRESHOLD = 5

  def index
    params[:page] ||= 1
    params[:page] = [params[:page].to_i, 1].max
   
    @page = params[:page] 
    offset = (@page-1)*PERPAGE
    @entries = Entry.offset(offset).limit(PERPAGE).where("favorite_cnt >= ?", FAV_THRESHOLD)

    @next_page = (Entry.count > @page*PERPAGE)
  end

  def about
  end
end
