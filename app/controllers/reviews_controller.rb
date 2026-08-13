class ReviewsController < ApplicationController
before_action :require_login, only: [:new, :create]

  def new
    @review = Review.new
  end

  def create
  end
  


end


