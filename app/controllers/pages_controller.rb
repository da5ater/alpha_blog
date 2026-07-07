class PagesController < ApplicationController
  def home
    @articles = Article.order(created_at: :desc).limit(5)
    redirect_to articles_path if logged_in?
  end

  def about
  end
end
