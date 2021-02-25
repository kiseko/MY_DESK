class Public::AmazonLinksController < ApplicationController

  before_action :ensure_current_user_item_nest


  def create
    @new_amazon_link = AmazonLink.new(amazon_link_params)
     @new_amazon_link.item_id = params[:item_id]
    if  @new_amazon_link.save
      redirect_to item_path(params[:item_id])
    else
      @item = Item.find(params[:item_id])
      @new_homepage_link = HomepageLink.new
      @homepage_link = HomepageLink.find_by(item_id: params[:item_id])
      render template: "public/items/link"
    end

  end

  def update
    @amazon_link = AmazonLink.find_by(item_id: params[:item_id])
    if  @amazon_link.update(amazon_link_params)
      redirect_to item_path(params[:item_id])
    else
      @item = Item.find(params[:item_id])
      @new_homepage_link = HomepageLink.new
      @homepage_link = HomepageLink.find_by(item_id: params[:item_id])
      render template: "public/items/link"
    end
  end

  def destroy
    @amazon_link = AmazonLink.find_by(item_id: params[:item_id])
    @amazon_link.destroy
    redirect_to item_path(params[:item_id])
  end


  private

  def amazon_link_params
    params.require(:amazon_link).permit(:url)
  end

end
