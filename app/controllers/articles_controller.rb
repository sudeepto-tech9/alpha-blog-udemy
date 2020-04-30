class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    # Need to whitelist params that we need to persist in our database.
    # Otherwise, we'll get ForbiddenAttributesError (Raised when forbidden attributes are used for mass assignment.)
    @article = Article.new(params.require(:article).permit(:title, :description))

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
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end
end