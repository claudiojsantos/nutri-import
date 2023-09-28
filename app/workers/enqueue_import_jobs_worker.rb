class EnqueueImportJobsWorker
  include Sidekiq::Worker

  def perform
    filenames = FetchFileUrlsService.call

    filenames.each do |filename|
      url = "https://challenges.coode.sh/food/data/json/#{filename}"

      ImportProductsWorker.perform_async(url)
    end
  end
end
