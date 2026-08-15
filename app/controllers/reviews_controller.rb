class ReviewsController < ApplicationController
before_action :require_login, only: [:new, :create]

  def new
    @review = Review.new
  end

  def index
    @reviews = Review.includes(:user)
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
     @review = Review.find(params[:id])
    if current_user.id == @review.user.id
       
    else
        redirect_to reviews_path, alert: "他のユーザーが投稿したレビューは編集できません。"
    end
  end

   def update
    @review = Review.find(params[:id])
    if current_user.id == @review.user_id
        if @review.update(review_params)
            redirect_to review_path(@review), notice: "レビューを更新しました。"
        else
            flash.now[:alert] = "レビューの更新に失敗しました。入力内容を確認してください。"
            render :edit, status: :unprocessable_entity
        end
    else
        redirect_to reviews_path, alert: "他のユーザーが投稿したレビューは編集できません。"
    end
   end      

   def destroy
    @review = Review.find(params[:id])
    if current_user.id == @review.user_id
        @review.destroy
        redirect_to reviews_path, notice: "レビューを削除しました。"
    else
        redirect_to reviews_path, alert: "他のユーザーが投稿したレビューは削除できません。"
    end
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


