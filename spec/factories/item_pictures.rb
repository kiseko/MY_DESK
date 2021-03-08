FactoryBot.define do
  factory :item_pictures do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample.png')) }
  end
end