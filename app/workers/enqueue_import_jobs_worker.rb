class EnqueueImportJobsWorker
  include Sidekiq::Worker

  def perform
    @start_cron = DateTime.now
    @memory_before = `ps -o rss= -p #{Process.pid}`.to_i
    filenames = Workers::FetchFileUrlsService.call

    @time_elapsed = Benchmark.realtime do
      filenames.each do |filename|
        url = "https://challenges.coode.sh/food/data/json/#{filename}"

        ImportProductsWorker.perform_async(url)
      end
    end

    @memory_after = `ps -o rss= -p #{Process.pid}`.to_i
    @finish_cron = DateTime.now

    CronHistory.create(
      start_cron: @start_cron,
      finish_cron: @finish_cron,
      memory_before: @memory_before,
      memory_after: @memory_after,
      time_elapsed: @time_elapsed
    )
  end
end
