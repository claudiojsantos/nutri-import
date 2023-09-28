require 'net/http'
require 'json'

class FetchFileUrlsService
  API_URL = 'https://challenges.coode.sh/food/data/json/index.txt'.freeze

  def self.call
    uri = URI(API_URL)
    response = Net::HTTP.get(uri)

    response.split("\n").select { |url| url.end_with?('.json.gz') }
  rescue StandardError => e
    Rails.logger.error("Error fetching file URLs: #{e.message}")
    []
  end
end
