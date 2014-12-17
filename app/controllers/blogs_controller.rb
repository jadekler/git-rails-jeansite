class BlogsController < ApplicationController
    before_action :set_blog, only: [:show]

    def index
        @blogs = Blog.all
        p @blogs
        @blogs
    end

    def show
    end

    private
    def set_blog
        @blog = Blog.find(params[:id])
    end
end
