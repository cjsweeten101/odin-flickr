class StaticPagesController < ApplicationController
	def home
		user_id = search_params[:id]
		unless user_id.nil?
			response = flickr.people.getPublicPhotos(user_id: user_id)
			@photo_urls = build_urls(response)
		end
	end

	private

	def build_urls(response)
		result = []
		response.each do |photo|
			result << "https://farm#{photo["farm"]}.staticflickr.com/#{photo["server"]}/#{photo["id"]}_#{photo["secret"]}.jpg"
		end
		result
	end

	def search_params
		params.require(:search).permit(:id) if params[:search].present?
	end
end
