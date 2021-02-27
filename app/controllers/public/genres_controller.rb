class Public::GenresController < ApplicationController

  before_action :ensure_current_user_item_nest


  def create
    @genre = Genre.new(genre_params)
    @genre.item_id = params[:item_id]
    if @genre.save
      redirect_to item_path(params[:item_id])
    else
      @item = Item.find(params[:item_id])
      @item_pictures = @item.item_pictures
      @homepage_link = @item.homepage_link
      @amazon_link = @item.amazon_link
      @genres = @item.genres
      @review = @item.review
      @user = @item.user
      render template: "public/items/show"
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to item_path(params[:item_id])
  end


  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
