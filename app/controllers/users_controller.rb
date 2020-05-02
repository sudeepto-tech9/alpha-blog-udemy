class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] =  "Welcome to the Alpha Blog #{@user.username}, you've successfully signed up."
      redirect_to articles_path
    else
      render 'new'
    end
  end

  private
  # def set_article
  #   @article = Article.find(params[:id])
  # end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end