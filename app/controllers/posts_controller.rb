class PostsController < ApplicationController
  def index
    @posts = Post.all
    censor_post_title
  end

  def show
    @post = Post.find(params[:id])
    censor_post_body
  end

  def censor_post_title
    #censor offensive language from index view
    @posts.each do |post|
      if post.title.include?("shit") || post.title.include?("fuck") || post.title.include?("ass") || post.title.include?("bitch") || post.title.include?("dick") || post.title.include?("cunt") || post.title.include?("damn")
        post.title = "Censored"
      end
    end
  end

  def censor_post_body
    #censor offensive language from show view
    post = @post
    post_body = post.body.split(" ")

    if post.title.include?("shit") || post.title.include?("fuck") || post.title.include?("ass") || post.title.include?("bitch") || post.title.include?("dick") || post.title.include?("cunt") || post.title.include?("damn")
      post.title = "Censored"
    end
    #iterate through post body
    post_body.each do |word|
      if word == "shit" || word == "fuck" || word == "ass" || word == "bitch" || word == "dick" || word == "cunt" || word == "damn"
        post.body = "This post has been censored due to offensive language."
      end
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Post was saved!"
      redirect_to @post
    else
      flash[:notice] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
  end
end
