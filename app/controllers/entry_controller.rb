class EntryController < ApplicationController
  def index
    @entries = Entry.all
  end
end
