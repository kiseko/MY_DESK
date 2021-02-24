class Public::ItemPicturesController < ApplicationController

  before_action :ensure_current_user
  def ensure_current_user
    @item = Item.find_by(id: params[:item_id])
    if @item.present?
      if current_user.id != @item.user_id
        redirect_to item_path(params[:item_id])
      end
    else
      redirect_to root_path
    end
  end


  def new
    @item_picture = ItemPicture.new
    @item = Item.find(params[:item_id])
    @homepage_link = @item.homepage_link
    @amazon_link = @item.amazon_link
    @genre = Genre.new
    @genres = @item.genres
    @review = @item.review
    @user = @item.user
  end

  def create
    @item_picture = ItemPicture.new(item_picture_params)
    @item_picture.item_id = params[:item_id]
    if @item_picture.save
      redirect_to item_path(params[:item_id])
    else
      @item = Item.find(params[:item_id])
      @homepage_link = @item.homepage_link
      @amazon_link = @item.amazon_link
      @genre = Genre.new
      @genres = @item.genres
      @review = @item.review
      @user = @item.user
      render :new
    end
  end

  def edit
    @item_picture = ItemPicture.find(params[:id])
    @item = Item.find(params[:item_id])
    @homepage_link = @item.homepage_link
    @amazon_link = @item.amazon_link
    @genre = Genre.new
    @genres = @item.genres
    @review = @item.review
    @user = @item.user
  end

  def update
    @item_picture = ItemPicture.find(params[:id])
    if @item_picture.update(item_picture_params)
      redirect_to item_path(params[:item_id])
    else
      @item = Item.find(params[:item_id])
      @homepage_link = @item.homepage_link
      @amazon_link = @item.amazon_link
      @genre = Genre.new
      @genres = @item.genres
      @review = @item.review
      @user = @item.user
        render :edit
    end
  end

  def destroy
    @item_picture = ItemPicture.find(params[:id])
    @item_picture.destroy
    redirect_to item_path(params[:item_id])
  end


  private

  def item_picture_params
    params.require(:item_picture).permit(:image)
  end

end
