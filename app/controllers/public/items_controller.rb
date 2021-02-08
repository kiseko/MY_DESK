class Public::ItemsController < ApplicationController

  def new
    @item = Item.new
    @item.item_pictures.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to user_item_path(id: @item.id)
    else
      render :new
    end

  end

  def index
  end

  def show
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
