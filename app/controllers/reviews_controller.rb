class ReviewsController < ApplicationController
before_action :require_login, only: [:new, :create]

  def new
    @review = Review.new
  end

  def index
    @reviews = Review.all
  end
  

  def create
   @review = current_user.reviews.build(review_params)
    if @review.save
        redirect_to root_path, notice: "レビューを投稿しました"
    else
        flash.now[:alert] = "レビューの投稿に失敗しました。入力内容を確認してください。"
        render :new, status: :unprocessable_entity
    end

  end
 
  private

  def review_params
    params.require(:review).permit(:title, :genre, :author, :comment, :impression)
  end



end


