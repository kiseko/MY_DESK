class Public::HomepageLinksController < ApplicationController

  before_action :ensure_current_user_item_nest


  def create
    @new_homepage_link = HomepageLink.new(homepage_link_params)
    @new_homepage_link.item_id = params[:item_id]
    if @new_homepage_link.save
      redirect_to item_path(params[:item_id])
    else
      @item = Item.find(params[:item_id])
      @new_amazon_link = AmazonLink.new
      @amazon_link = AmazonLink.find_by(item_id: params[:item_id])
      render template: "public/items/link"
    end

  end

  def update
    @homepage_link = HomepageLink.find_by(item_id: params[:item_id])
    if @homepage_link.update(homepage_link_params)
      redirect_to item_path(params[:item_id])
    else
      @item = Item.find(params[:item_id])
      @new_amazon_link = AmazonLink.new
      @amazon_link = AmazonLink.find_by(item_id: params[:item_id])
      render template: "public/items/link"
    end
  end

  def destroy
    @homepage_link = HomepageLink.find_by(item_id: params[:item_id])
    @homepage_link.destroy
    redirect_to item_path(params[:item_id])
  end


  private

  def homepage_link_params
    params.require(:homepage_link).permit(:url)
  end

end
