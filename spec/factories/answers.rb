FactoryGirl.define do
  factory :answer do
    body RandomData.random_paragraph
    question
    user
  end
end
