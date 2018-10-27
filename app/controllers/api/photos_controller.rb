# frozen_string_literal: true

module Api
  class PhotosController < ApplicationController
    before_action :authenticate_user

    def index
      photos = paginate Photo.all
      render json: PhotoSerializer.new(photos).serialized_json
    end

    def create
      photo = Photo.create!(photo_params)
      ExifWorker.perform_async(photo.id)
      render json: photo, status: :created
    end

    private

    def photo_params
      params.require(:photo).permit(:file)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end
end
