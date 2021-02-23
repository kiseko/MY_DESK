class Public::ReviewsController < ApplicationController

  before_action :ensure_current_user
  def ensure_current_user
    @item = Item.find(params[:item_id])
    if current_user.id != @item.user_id
      redirect_to item_path(params[:item_id])
    end
  end

  def new
    @review = Review.new
    @item_picture = ItemPicture.find_by(item_id: params[:item_id])
  end

  def create
    @review = Review.new(review_params)
    @review.item_id = params[:item_id]
    if @review.save
      redirect_to item_path(params[:item_id])
    else
      @item_picture = ItemPicture.find_by(item_id: params[:item_id])
      render :new
    end
  end

  def edit
    @review = Review.find_by(item_id: params[:item_id])
    @item_picture = ItemPicture.find_by(item_id: params[:item_id])
  end

  def update
    @review = Review.find_by(item_id: params[:item_id])
    if @review.update(review_params)
      redirect_to item_path(params[:item_id])
    else
      @item_picture = ItemPicture.find_by(item_id: params[:item_id])
      render :edit
    end
  end

  def destroy
    @review = Review.find_by(item_id: params[:item_id])
    @review.destroy
    redirect_to item_path(params[:item_id])
  end


  private

  def review_params
    params.require(:review).permit(:rating, :description)
  end

end
