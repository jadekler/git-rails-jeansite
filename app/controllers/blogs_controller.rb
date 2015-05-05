class BlogsController < ApplicationController
  def index
    p '8'*80
    @blogs = Blog.order(created_at: :desc)
  end

  def show
  end
end
