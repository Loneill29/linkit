module UsersHelper
  def user_has_comments?
    if @user.comments.any?
      @user.comments
    else
      "#{@user.name} has not written any comments yet."
    end
  end

  def user_has_posts?
    if @user.posts.any?
      @user.posts
    else
      "#{@user.name} has not written any posts yet."
    end
  end

  def user_has_favorites?
    if @user.favorites.any?
      @user.favorites
    else
      "#{@user.name} has not favorited any posts yet."
    end
  end
end
