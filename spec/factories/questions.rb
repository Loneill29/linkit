FactoryBot.define do
  factory :question do
    title RandomData.random_sentence
    body RandomData.random_paragraph
    user
  end
end
