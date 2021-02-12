class Public::GenresController < ApplicationController

  def create
    @genre = Genre.new(genre_params)
    @genre.item_id = params[:item_id]
    if @genre.save
      redirect_to item_path(params[:item_id])
    else
      @item = Item.find(params[:item_id])
      @item_pictures = @item.item_pictures
      @genres = @item.genres
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
