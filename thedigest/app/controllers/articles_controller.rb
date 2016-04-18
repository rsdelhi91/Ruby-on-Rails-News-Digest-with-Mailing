# Creates the article object, handles the tasks to create, show interests,
# scrape, email articles.
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    if params[:search]
      @articles = Article.weight_search(params[:search])
    else
      @search = Article.search(params[:q])
      @articles = @search.result.reverse
    end

    @articles = Kaminari.paginate_array(@articles).page(params[:page]).per(10)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @search = Article.search(params[:q])
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  def my_interests
    @search = Article.search(params[:q])
    @articles = Article.tagged_with(current_user.interest_list, any: true)
                .to_a
    @articles = Kaminari.paginate_array(@articles).page(params[:page]).per(10)
    render 'index'
  end

  # GET /admin/scrape
  def fetch
    # initialize the processor
    processor = ArticleProcessor.new
    # scrape all articles
    processor.import_article
    # redirect to article index page
    redirect_to articles_path, notice: 'Scrape successfully'
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html do
          redirect_to @article, notice:
          'Article was successfully created.'
        end
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json do
          render json: @article.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # GET /admin/email
  # Send the matched email to every user with subscription on
  def email
    # Need to get the list of the user with subscription on
    # Need to get the content for each user
    update_subscriber_list
    send_email_to_all
    redirect_to articles_path, notice: 'Email successfully'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white
  # list through.
  def article_params
    params.require(:article).permit(:source, :title, :datePub, :summary,
                                    :author, :img, :link, :tag_list)
  end
end
