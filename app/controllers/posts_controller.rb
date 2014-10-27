class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end


  def new  # Show the post form

  end


  def create  # Handle the submission of the new post form

  end


  def edit # Display the edit post form

  end


  def update # The submission of the edit of the post form

  end

end
