require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:my_question) { create(:question, user: my_user) }
  let(:my_answer) { create(:answer) }

  context "guest" do
    describe "POST create" do
      it "redirects the user to the sign in view" do
        question :create, params: { question_id: my_question.id, answer: { body: RandomData.random_paragraph } }
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "DELETE destroy" do
      it "redirects the user to the sign in view" do
        delete :destroy, params: { question_id: my_question.id, id: my_answer.id }
        expect(response).to redirect_to(new_session_path)
      end
    end
end
