# frozen_string_literal: true

include ActionDispatch::TestProcess

FactoryBot.define do
  factory :photo do
    filename = "spec/fixtures/files/#{[1, 2, 3].sample}.jpg"
    file { fixture_file_upload filename, 'image/jpeg' }
  end

  factory :user do
    email { 'test@test.com' }
    password { '12345678' }
  end
end
