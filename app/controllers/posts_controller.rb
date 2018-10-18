class PostsController < ApplicationController
  def index
    @posts = Post.all
    #censor offensive language
    @posts.each do |post|
      post_title = post.title.split(" ")
      post_body = post.body.split(" ")
      #if a post title includes a curse word, censor the title
      post_title.each do |word|
        if post_title.include?("shit") || post_title.include?("fuck") || post_title.include?("ass") || post_title.include?("bitch") || post_title.include?("dick") || post_title.include?("cunt") || post_title.include?("damn")
          post.title = "Censored"
        end
      end
      #if a post body contains a curse word, censor the body
      post_body.each do |word|
        if post_body.include?("shit") || post_body.include?("fuck") || post_body.include?("ass") || post_body.include?("bitch") || post_body.include?("dick") || post_body.include?("cunt") || post_body.include?("damn")
          post.body = "This post has been censored due to offensive language"
        end
      end
    end
  end

  def show
  end

  def new
  end

  def edit
  end
end
