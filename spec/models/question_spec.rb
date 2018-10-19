require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { Question.create!(title: "New Question Title", body: "New question body", resolved: true) }

  describe "attributes" do
    it "has title and body attributes" do
      expect(question).to have_attributes(title: "New Question Title", body: "New question body", resolved: true)
    end
  end
end
