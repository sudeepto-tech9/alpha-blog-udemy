class ArticlesController < ApplicationController

  # before_action helper method runs the metioned method inside the actions specified as the first statement.
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    # Need to whitelist params that we need to persist in our database.
    # Otherwise, we'll get ForbiddenAttributesError (Raised when forbidden attributes are used for mass assignment.)
    @article = Article.new(article_params)

    if @article.save
      # This line inspects the instance variable value to the HTML
      # render plain: @article.inspect

      # Using Rails helper method 'flash'

      # Rails will extract the 'id' from '@article' instance variable and redirect the app to the newly created article show page.
      # redirect_to article_path(@article)
      # We can also write the above statement in a concise manner :
      redirect_to @article, notice: "Articles created successfully"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy

    # 'rails routes' command articles_path = Prefix_path . So if the prefix is edit_article, then the path would edit_article_path
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end