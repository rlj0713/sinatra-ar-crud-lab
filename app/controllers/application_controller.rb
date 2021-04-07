require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/articles"
  end
 
  # Index
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  # New
  get '/articles/new' do
    @article = Article.new
    erb :new
  end
  
  # Create
  post '/articles' do
    @article = Article.create(params)
    if @article == nil
      redirect to "/articles/new"
    else
      redirect to "/articles/#{ @article.id }"
    end
  end

  # Show
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end
  
  # Edit
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  # Update
  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{ @article.id }"
  end

  # Destroy
  delete '/articles/:id' do
    Article.destroy(params[:id])
    redirect to '/articles'
  end
end