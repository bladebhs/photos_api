include ActionDispatch::TestProcess

FactoryBot.define do
  factory :photo do
    file { fixture_file_upload "spec/fixtures/files/#{[1,2,3].sample}.jpg", 'image/jpeg' }
  end
end