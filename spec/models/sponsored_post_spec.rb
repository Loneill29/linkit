require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:price) { RandomData.random_number }
  #create a parent topic for sponsored_post
  let(:topic) { Topic.create!(name:name, description: description) }
  #chained method call creates a sponsored_post for a given topic
  let(:sponsored_post) { topic.sponsored_posts.create!(title: title, body: body, price: price) }

  it { is_expected.to belong_to(:topic) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:topic) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }

  describe "attributes" do
    it "has title, body, and price attributes" do
      expect(sponsored_post).to have_attributes(title: title, body: body, price: price)
    end
  end
end
