class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    censor_question_title
  end

  def show
    @question = Question.find(params[:id])
    censor_question_body
    resolved?
  end

  def censor_question_title
    #censor offensive language from index view
    @questions.each do |question|
      if question.title.include?("shit") || question.title.include?("fuck") || question.title.include?("ass") || question.title.include?("bitch") || question.title.include?("dick") || question.title.include?("cunt") || question.title.include?("damn")
        question.title = "Censored"
      end
    end
  end

  def censor_question_body
    #censor offensive language from show view
    question = @question
    question_body = question.body.split(" ")

    if question.title.include?("shit") || question.title.include?("fuck") || question.title.include?("ass") || question.title.include?("bitch") || question.title.include?("dick") || question.title.include?("cunt") || question.title.include?("damn")
      question.title = "Censored"
    end
    #iterate through question body
    question_body.each do |word|
      if word == "shit" || word == "fuck" || word == "ass" || word == "bitch" || word == "dick" || word == "cunt" || word == "damn"
        question.body = "This question has been censored due to offensive language."
      end
    end
  end

  def resolved?
    @question = Question.find(params[:id])

    if @question.resolved
      flash[:notice] = "This question has been resolved."
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new
    @question.title = params[:question][:title]
    @question.body = params[:question][:body]
    @question.resolved = params[:question][:resolved]

    if @question.save
      flash[:notice] = "Question was saved!"
      redirect_to @question
    else
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.title = params[:question][:title]
    @question.body = params[:question][:body]
    @question.resolved = params[:question][:resolved]


    if @question.save
      flash[:notice] = "Question was updated!"
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])

    if @question.destroy
      flash[:notice] = "\"#{@question.title}\" was deleted successfully!"
      redirect_to questions_path
    else
      flash.now[:alert] = "There was an error deleting the question. Please try again."
      render :show
    end
  end
end
