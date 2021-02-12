class Public::ItemsController < ApplicationController

  def new
    @item = Item.new
    @item.item_pictures.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item.id)
    else
      render :new
    end

  end

  def index
  end

  def show
    @item = Item.find(params[:id])
    @item_pictures = @item.item_pictures.limit(4)
    @homepage_link = @item.homepage_link
    @amazon_link = @item.amazon_link
    @genre = Genre.new
    @genres = @item.genres
    @review = @item.review
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
  end

  def link
    @item = Item.find(params[:id])
    @new_homepage_link = HomepageLink.new
    @homepage_link = HomepageLink.find_by(item_id: params[:id])
    @new_amazon_link = AmazonLink.new
    @amazon_link = AmazonLink.find_by(item_id: params[:id])
  end


  private

  def item_params
    params.require(:item).permit(:brand, :name, item_pictures_attributes: [:image]).merge(user_id: current_user.id)
  end

end
