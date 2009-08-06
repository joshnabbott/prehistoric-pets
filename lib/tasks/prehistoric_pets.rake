namespace :prehistoric_pets do
  namespace :db do
    desc 'Removes image records that are missing image files on the server'
    task :prune_orders => :environment do
      time = Benchmark.measure do
        @records_deleted = 0
        Order.destroy_all("updated_at < '#{(Time.now - 1.week).to_s(:db)}' AND state IN ('in_cart', 'pending')")
      end # Benchmark
      puts "Deleted #{@records_deleted} bad image records in %.4fs" % time.real
    end # prune_orders
  end # db

  namespace :images do
    desc 'Removes image records that are missing image files on the server'
    task :prune => :environment do
      time = Benchmark.measure do
        @records_deleted = 0
        Image.find_in_batches do |images|
          images.each do |image|
            unless image.has_image?
              image.destroy
              @records_deleted += 1
            end
          end
        end # find_in_batches
      end # Benchmark
      puts "Deleted #{@records_deleted} bad image records in %.4fs" % time.real
    end # prune
  end # images
end # prehistoric_pets