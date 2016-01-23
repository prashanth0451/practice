class BlogsController < ApplicationController

  before_action :set_blog, only: [:edit, :show, :update, :destroy]
  before_action :raise_error, only: [:edit, :update, :destroy ]
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @blogs = Blog.all
  end

  def edit
  end

  def show
    @comment = Blogs::Comment.new
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user
    if @blog.save
      redirect_to blog_path(@blog), flash: {notice: "Blog was created!"}
    else
      render :new
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_path(@blog), flash: {notice: "Blog was updated!"}
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to root_path, flash: {notice: "Blog was deleted!"}
  end

  def raise_error
    if @blog.user != current_user
      raise "You are not authorized to do this operation. Incident will pe reported with IP."
    end
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :image)
  end
end
