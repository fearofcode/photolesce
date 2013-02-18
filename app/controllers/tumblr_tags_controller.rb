class TumblrTagsController < ApplicationController
  http_basic_authenticate_with name: "admin", :password => ADMIN_PASS

  def new
    @tag = TumblrTag.new
  end

  def create
    puts params
    @tag = TumblrTag.new(params[:tumblr_tag])

    if @tag.save
      redirect_to feeds_path, notice: "Tag was successfully created."
    else
      render action: "new"
    end
  end

  def destroy
    @tag = TumblrTag.find(params[:id])
    @tag.destroy

    redirect_to feeds_path
  end
end
