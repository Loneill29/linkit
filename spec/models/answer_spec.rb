require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  it { is_expected.to belong_to(:question) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "has a body attribute" do
      expect(answer).to have_attributes(answer: answer.body)
    end
  end

  describe "after_create" do
    before do
      @another_answer = Answer.new(body: 'answer Body', question: question, user: user)
    end

    it "sends an email to users who have favorited the question" do
      favorite = user.favorites.create(question: question)
      expect(FavoriteMailer).to receive(:new_answer).with(user, question, @another_answer).and_return(double(deliver_now: true))

      @another_answer.save!
    end

    it "does not send emails to users who haven't favorited the question" do
      expect(FavoriteMailer).not_to receive(:new_answer)

      @another_answer.save!
    end
  end
end
