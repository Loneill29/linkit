class AnswersController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    @question = Question.find(params[:question_id])
    answer = @question.answers.new(answer_params)
    answer.user = current_user

    if answer.save
      flash.now[:notice] = "Answer saved successfully."
      redirect_to [@question]
    else
      flash.now[:alert] = "Answer failed to save."
      redirect_to [@question]
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    answer = @question.answers.find(params[:id])

    if answer.destroy
      flash.now[:notice] = "Answer was deleted."
      redirect_to [@question]
    else
      flash.now[:alert] = "Answer couldn't be deleted. Try again."
      redirect_to [@question]
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def authorize_user
    answer = Answer.find(params[:id])

    unless current_user == answer.user || current_user.admin?
      flash.now[:alert] = "You do not have permission to delete a answer."
      redirect_to [answer.question]
    end
  end
end
