class EntryController < ApplicationController
  PERPAGE = 5

  def index
    params[:page] ||= 1
    params[:page] = [params[:page].to_i, 1].max
   
    @page = params[:page] 
    offset = (@page-1)*PERPAGE
    @entries = Entry.offset(offset).limit(PERPAGE)

    @next_page = (Entry.count > @page*PERPAGE)
  end
end
