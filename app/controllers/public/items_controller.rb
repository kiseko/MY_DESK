class Public::ItemsController < ApplicationController

  before_action :ensure_current_user_item, {only: [:edit, :update, :destroy, :link]}
  def ensure_current_user_item
    @item = Item.find_by(id: params[:id])
    if @item.present?
      if current_user.id != @item.user_id
        redirect_to item_path(params[:id])
      end
    else
      redirect_to root_path
    end
  end


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
    @items = current_user.items.order(updated_at: "DESC").page(params[:page]).per(10)
  end

  def show
    @item = Item.find_by(id: params[:id])
    if @item.present?
      @item_pictures = @item.item_pictures.limit(4)
      @homepage_link = @item.homepage_link
      @amazon_link = @item.amazon_link
      @genre = Genre.new
      @genres = @item.genres
      @review = @item.review
      @user = @item.user
    end
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
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  def link
    @item = Item.find(params[:id])
    @new_homepage_link = HomepageLink.new
    @homepage_link = @item.homepage_link
    @new_amazon_link = AmazonLink.new
    @amazon_link = @item.amazon_link
  end

  def search
     @search_items = Item.search(params[:search])
     @scene_items = SceneItem.where(item_id: @search_items.ids).includes(item: :user).where(users: {status: 0}).order(updated_at: "DESC").page(params[:page]).per(8)
     @search_value = (params[:search])
  end


  private

  def item_params
    params.require(:item).permit(:brand, :name, item_pictures_attributes: [:image]).merge(user_id: current_user.id)
  end

end
