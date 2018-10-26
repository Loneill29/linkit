class TopicsController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]


  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def censor_topic_title
    #censor offensive language from index view
    @topics.each do |topic|
      if topic.title.include?("shit") || topic.title.include?("fuck") || topic.title.include?("ass") || topic.title.include?("bitch") || topic.title.include?("dick") || topic.title.include?("cunt") || topic.title.include?("damn")
        topic.title = "Censored"
      end
    end
  end

  def censor_topic_description
    #censor offensive language from show view
    topic = @topic
    topic_description = topic.description.split(" ")

    if topic.title.include?("shit") || topic.title.include?("fuck") || topic.title.include?("ass") || topic.title.include?("bitch") || topic.title.include?("dick") || topic.title.include?("cunt") || topic.title.include?("damn")
      topic.title = "Censored"
    end
    #iterate through topic description
    topic_description.each do |word|
      if word == "shit" || word == "fuck" || word == "ass" || word == "bitch" || word == "dick" || word == "cunt" || word == "damn"
        topic.description = "This topic has been censored due to offensive language."
      end
    end
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to @topic, notice: "Topic was saved!"
    else
      flash[:alert] = "There was an error saving the topic. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Topic was updated!"
      redirect_to @topic
    else
      flash[:alert] = "There was an error updating the topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name} was deleted successfully."
      redirect_to action: :index
    else
      flash[:alert] = "There was an error deleting the topic. Please try again."
      render :show
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end

  def authorize_user
    action = params['action']
    if (action == "new" || action == "create" || action == "destroy") && !current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to topics_path
    elsif action == "update" && !(current_user.admin? || current_user.moderator?)
      flash[:alert] = "You must be an admin or moderator to do that."
      redirect_to topics_path
    end
  end
end
