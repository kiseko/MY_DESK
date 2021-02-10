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
    @item_pictures = @item.item_pictures
    @genre = Genre.new
    @genres = @item.genres
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def item_params
    params.require(:item).permit(:brand, :name, item_pictures_attributes: [:image]).merge(user_id: current_user.id)
  end

end
