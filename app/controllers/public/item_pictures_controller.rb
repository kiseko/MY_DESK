class Public::ItemPicturesController < ApplicationController

  def new
    @item_picture = ItemPicture.new
    @item = Item.find(params[:item_id])
    @genre = Genre.new
    @genres = @item.genres
    @review = @item.review
  end

  def create
    @item_picture = ItemPicture.new(item_picture_params)
    @item_picture.item_id = params[:item_id]
    if @item_picture.save
      redirect_to item_path(params[:item_id])
    else
      @item = Item.find(params[:item_id])
      @genre = Genre.new
      @genres = @item.genres
      @review = @item.review
      render :new
    end
  end

  def edit
    @item_picture = ItemPicture.find(params[:id])
    @item = Item.find(params[:item_id])
    @genre = Genre.new
    @genres = @item.genres
    @review = @item.review

  end

  def update
    @item_picture = ItemPicture.find(params[:id])
    if @item_picture.update(item_picture_params)
      redirect_to item_path(params[:item_id])
    else
      @item = Item.find(params[:item_id])
      @genre = Genre.new
      @genres = @item.genres
      @review = @item.review
      render :edit
    end


  end

  def destroy
  end


  private

  def item_picture_params
    params.require(:item_picture).permit(:image)
  end

end
